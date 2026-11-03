part of '../extensions.dart';

extension MPermissionStore on IUserPermission {
  /// Xin quyền ảnh đúng chuẩn Android 13–16 + photo_manager.
  ///
  /// Trên API 33+ (đặc biệt emulator API 36):
  /// - Chỉ bật Photos trong Settings + Permission.storage là KHÔNG đủ
  /// - Bắt buộc gọi PhotoManager.requestPermissionExtend()
  /// - Chấp nhận cả full access (isAuth) và limited access (hasAccess)
  requestStoragePermission(BuildContext context, {
    Function? onHasPermission,
    Function? onNoPermission,
  }) async {
    bool called = false;

    Future<bool> ensurePhotoAccess() async {
      try {
        // Quan trọng nhất: xin qua photo_manager
        final PermissionState ps = await PhotoManager.requestPermissionExtend(
          requestOption: const PermissionRequestOption(
            androidPermission: AndroidPermission(
              type: RequestType.common, // images + video → tránh bug denied khi thiếu VIDEO
              mediaLocation: false,
            ),
          ),
        );

        // isAuth = full, hasAccess = limited (user chọn vài ảnh trên Android 14+)
        if (ps.isAuth || ps.hasAccess) {
          return true;
        }
      } catch (_) {
        // fallback bên dưới
      }

      // Fallback permission_handler
      try {
        final List<Permission> perms = [
          if (Platform.isIOS) Permission.photos,
          if (Platform.isAndroid) ...[
            Permission.photos,
            Permission.videos,
            Permission.storage,
          ],
        ];

        final Map<Permission, PermissionStatus> statuses = await perms.request();
        final bool anyGranted = statuses.values.any(
          (s) => s.isGranted || s.isLimited,
        );

        if (anyGranted) {
          final PermissionState ps2 =
              await PhotoManager.requestPermissionExtend();
          return ps2.isAuth || ps2.hasAccess;
        }
      } catch (_) {}

      return false;
    }

    final bool ok = await ensurePhotoAccess();

    if (ok) {
      if (onHasPermission != null) onHasPermission();
      return;
    }

    // Không có quyền → popup mở Settings
    WidgetUtils.instance.showRequestPermissionPopup(
      title:
          '${Configuration.instance.business.appName} ${S.of(context).wouldLikeToAccessYourPhotos}',
      message:
          '${S.of(context).allow} ${Configuration.instance.business.appName} ${S.of(context).toAccessPhotosOnYourDeviceToEditOrShare}',
      onForeground: () async {
        await PhotoManager.openSetting();
        final bool ok2 = await ensurePhotoAccess();
        if (ok2 && !called) {
          called = true;
          WidgetUtils.instance.dismiss();
          if (onHasPermission != null) onHasPermission();
        }
      },
    );

    if (onNoPermission != null) {
      onNoPermission();
    }
  }
}
