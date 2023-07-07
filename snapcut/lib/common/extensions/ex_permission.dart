part of '../extensions.dart';

extension MPermissionStore on IUserPermission {
  requestStoragePermission(BuildContext context, {
    Function? onHasPermisson,
    Function? onNoPermisson,
  }) async {
    final permission = [Permission.storage];
    // bool called = false; /// FIX GOBACK
    requestPermission(
      permission: permission,
      onNoPermisson: () {
        // WidgetUtils.instance.showRequestPermissionPopup(
        //   title:'${Configuration.instance.business.appName} ${S.of(context).wouldLikeToAccessYourPhotos}',
        //   message: '${S.of(context).allow} ${Configuration.instance.business.appName} ${S.of(context).toAccessPhotosOnYourDeviceToEditOrShare}',
        //   onForeground: () {
        //     requestPermission(
        //       permission: permission,
        //       onHasPermisson: () {
        //         if(!called) {
        //           called = true;
        //           WidgetUtils.instance.dimiss();
        //         }
        //       },
        //     );
        //   },
        // );
        // if (onNoPermisson != null) {
        //   onNoPermisson();
        // }
      },
      onHasPermisson: onHasPermisson,
    );
  }
}
