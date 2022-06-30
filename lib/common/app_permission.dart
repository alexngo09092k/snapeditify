import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/widgets/no_permission_popup.dart';

class AppPermission {
  static final AppPermission _instance = AppPermission._internal();
  static AppPermission get instance => _instance;

  factory AppPermission() => _instance;

  AppPermission._internal();

  requestPermission({
    required List<Permission> permission,
    Function? onHasPermisson,
    Function? onNoPermisson,
  }) async {
    Map<Permission, PermissionStatus> statuses = await permission.request();
    final PermissionStatus? status = statuses[Permission.storage];
    checkingStatus(
      status: status,
      onHasPermisson: onHasPermisson,
      onNoPermisson: onNoPermisson,
    );
  }

  checkingStatus({
    PermissionStatus? status,
    Function? onHasPermisson,
    Function? onNoPermisson,
  }) {
    printLog('Permission $status');
    switch (status) {

      /// The user denied access to the requested feature.
      case PermissionStatus.denied:

      /// The OS denied access to the requested feature. The user cannot change
      /// this app's status, possibly due to active restrictions such as parental
      /// controls being in place.
      /// *Only supported on iOS.*
      case PermissionStatus.restricted:

      /// dialog will not be shown when requesting this permission. The user may
      /// still change the permission status in the settings.
      /// *Only supported on Android.*
      case PermissionStatus.permanentlyDenied:
        if (onNoPermisson != null) onNoPermisson();
        break;

      /// The user granted access to the requested feature.
      case PermissionStatus.granted:

      ///User has authorized this application for limited access.
      /// *Only supported on iOS (iOS14+).*
      case PermissionStatus.limited:
        if (onHasPermisson != null) onHasPermisson();
        break;
      default:
        break;
    }
  }
}

extension AppPermissionStore on AppPermission {
  requestStorePermission({
    BuildContext? context,
    Function? onHasPermisson,
    Function? onNoPermisson,
  }) async {
    requestPermission(
      permission: [Permission.storage],
      onNoPermisson: () {
        if (context != null) {
          showDialog(
            context: context,
            builder: (_) => NoPermissonPopup(
              message: 'Allow app to access photos and media on your device.',
              manualSetupTitle: 'Open settings',
              onManualSetup: (_) {
                AppSettings.openAppSettings();
              },
              onBackApp: () async {
                requestPermission(
                  permission: [Permission.storage],
                  onHasPermisson: Navigator.of(context).pop,
                );
              },
            ),
          );
        }
        if (onNoPermisson != null) {
          onNoPermisson();
        }
      },
      onHasPermisson: onHasPermisson,
    );
  }
}
