part of '../extensions.dart';

extension MPermissionStore on IUserPermission {
  requestStoragePermission(BuildContext context, {
    Function? onHasPermission,
    Function? onNoPermission,
  }) async {
    // Android 13+ (API 33) dùng Permission.photos (READ_MEDIA_IMAGES)
    // Android < 13 dùng Permission.storage (READ_EXTERNAL_STORAGE)
    // iOS dùng Permission.photos
    final List<Permission> permission = [
      if (Platform.isIOS) Permission.photos,
      if (Platform.isAndroid) ...[
        Permission.photos,   // bắt buộc cho Android 13+
        Permission.storage,  // giữ lại để tương thích Android 12 trở xuống
      ],
    ];

    bool called = false; /// FIX GOBACK
    requestPermission(
      permission: permission,
      onNoPermission: () {
        WidgetUtils.instance.showRequestPermissionPopup(
          title:'${Configuration.instance.business.appName} ${S.of(context).wouldLikeToAccessYourPhotos}',
          message: '${S.of(context).allow} ${Configuration.instance.business.appName} ${S.of(context).toAccessPhotosOnYourDeviceToEditOrShare}',
          onForeground: () {
            requestPermission(
              permission: permission,
              onHasPermission: () {
                if(!called) {
                  called = true;
                  WidgetUtils.instance.dismiss();
                }
              },
            );
          },
        );
        if (onNoPermission != null) {
          onNoPermission();
        }
      },
      onHasPermission: onHasPermission,
    );
  }
}
