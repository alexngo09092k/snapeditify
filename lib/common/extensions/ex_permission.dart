part of '../extensions.dart';

extension MPermissionStore on UserPermission {
  requestStoragePermission(BuildContext context, {
    Function? onHasPermisson,
    Function? onNoPermisson,
  }) async {
    final permission = [Permission.storage];
    requestPermission(
      permission: permission,
      onNoPermisson: () {
        WidgetUtils.instance.showRequestPermissionPopup(
          title: S.of(context).wouldLikeToAccessYourPhotos,
          message: '${S.of(context).allow} ${Configuration.instance.business.appName} ${S.of(context).toAccessPhotosOnYourDeviceToEditOrShare}',
          onForeground: () {
            requestPermission(
              permission: permission,
              onHasPermisson: WidgetUtils.instance.dimiss,
            );
          },
        );
        if (onNoPermisson != null) {
          onNoPermisson();
        }
      },
      onHasPermisson: onHasPermisson,
    );
  }
}
