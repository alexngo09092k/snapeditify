part of '../extensions.dart';

extension MPermissionStore on IUserPermission {
  /// Xin quyền ảnh cho:
  /// - Android 10–12 (storage)
  /// - Android 13–16 (READ_MEDIA_*)
  /// - Huawei EMUI / HarmonyOS (AppGallery)
  ///
  /// Luồng: PhotoManager → permission_handler → mở Settings nếu cần.
  requestStoragePermission(
    BuildContext context, {
    Function? onHasPermission,
    Function? onNoPermission,
  }) async {
    bool called = false;

    Future<bool> ensurePhotoAccess() async {
      // --- Bước 1: PhotoManager (bắt buộc trên API 33+) ---
      try {
        final PermissionState ps = await PhotoManager.requestPermissionExtend(
          requestOption: const PermissionRequestOption(
            androidPermission: AndroidPermission(
              // common = images + video → tránh bug denied khi thiếu VIDEO
              type: RequestType.common,
              mediaLocation: false,
            ),
          ),
        );
        if (ps.isAuth || ps.hasAccess) {
          return true;
        }
      } catch (_) {
        // Tiếp tục fallback
      }

      // --- Bước 2: permission_handler (Huawei / máy cũ hay cần thêm) ---
      try {
        final List<Permission> perms = <Permission>[
          if (Platform.isIOS) Permission.photos,
          if (Platform.isAndroid) ...[
            Permission.photos,
            Permission.videos,
            Permission.storage, // EMUI cũ / Android <= 12
          ],
        ];

        // Xin từng cái để Huawei dialog ổn định hơn
        for (final p in perms) {
          final status = await p.status;
          if (!status.isGranted && !status.isLimited) {
            await p.request();
          }
        }

        final PermissionState ps2 = await PhotoManager.requestPermissionExtend();
        if (ps2.isAuth || ps2.hasAccess) {
          return true;
        }

        // Một số máy Huawei báo limited/denied nhưng vẫn đọc được MediaStore
        // → thử kiểm tra thực tế bằng getAssetPathList
        try {
          final paths = await PhotoManager.getAssetPathList(
            type: RequestType.image,
            onlyAll: true,
          );
          if (paths.isNotEmpty) {
            final count = await paths.first.assetCountAsync;
            if (count > 0) return true;
          }
        } catch (_) {}
      } catch (_) {}

      return false;
    }

    final bool ok = await ensurePhotoAccess();
    if (ok) {
      if (onHasPermission != null) onHasPermission();
      return;
    }

    // Không có quyền → hướng dẫn Settings (Huawei: Apps → Permissions → Storage/Photos)
    WidgetUtils.instance.showRequestPermissionPopup(
      title:
          '${Configuration.instance.business.appName} ${S.of(context).wouldLikeToAccessYourPhotos}',
      message:
          '${S.of(context).allow} ${Configuration.instance.business.appName} ${S.of(context).toAccessPhotosOnYourDeviceToEditOrShare}',
      onForeground: () async {
        try {
          await PhotoManager.openSetting();
        } catch (_) {
          await openAppSettings();
        }
        final bool ok2 = await ensurePhotoAccess();
        if (ok2 && !called) {
          called = true;
          WidgetUtils.instance.dismiss();
          if (onHasPermission != null) onHasPermission();
        }
      },
    );

    if (onNoPermission != null) onNoPermission();
  }
}
