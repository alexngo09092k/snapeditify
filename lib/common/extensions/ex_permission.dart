part of '../extensions.dart';

extension MPermissionStore on IUserPermission {
  requestStoragePermission(BuildContext context, {
    Function? onHasPermission,
    Function? onNoPermission,
  }) async {
    final permission = [Permission.storage];
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
