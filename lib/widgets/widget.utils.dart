import 'package:app_settings/app_settings.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/loading_popup.dart';
import 'package:snapedit/widgets/no_internet_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/widgets/no_permission_popup.dart';

Future<T?> showPopup<T>(BuildContext context, Widget popup, {bool barrierDismissible = true}) {
  return showCupertinoModalPopup<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => popup,
  );
}

Future<T?> showNoInternetPopup<T>(BuildContext context, [Function(BuildContext)? retry, Function(BuildContext)? onCancel]) {
  return showPopup<T>(
    context,
    NoInternetPoup(
      retry: retry,
      onCancel: onCancel,
    ),
    barrierDismissible: false,
  );
}

Future<T?> showNoPermissionPopup<T>(
  BuildContext context, {
  required String message,
  dynamic Function(BuildContext context)? onBackApp,
}) {
  return showPopup<T>(
    context,
    NoPermissionPopup(
      message: message,
      manualSetupTitle: 'Open settings',
      onManualSetup: (_) => AppSettings.openAppSettings(),
      onBackApp: (_) {
        if (onBackApp != null) onBackApp(_);
      },
    ),
  );
}

Future<T?> showLoadingPopup<T>(BuildContext context, {required String message}) {
  return showPopup<T>(
    context,
    LoadingPopup(message: message),
    barrierDismissible: false,
  );
}

Future<T?> showModalBottom<T>(BuildContext context, Widget modal) {
  return showModalBottomSheet<T>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppDimensions.instance.radius),
        topRight: Radius.circular(AppDimensions.instance.radius),
      ),
    ),
    builder: (_) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: modal,
    ),
  );
}
