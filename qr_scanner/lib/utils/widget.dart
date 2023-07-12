import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/base/custom_alert.dart';

class WidgetUtils {
  static final WidgetUtils _instance = WidgetUtils._internal();

  static WidgetUtils get instance => _instance;

  WidgetUtils._internal();

  Future<T?> showDialog<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return AwesomeAppState.dialog<T>(
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  Future<T?> showWarningPopup<T>({
    required String title,
    required message,
    Function(BuildContext)? retry,
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return AwesomeAppState.useContext<T>(callback: (BuildContext context) {
      return alert<T>(
        context,
        title: title,
        message: message,
        onBackground: onBackground,
        onForeground: onForeground,
        actions: [
          AlertAction(title: "Cancel", onPressed: Navigator.of(context).pop),
          if (retry != null)
            AlertAction(
              title: "Retry",
              // isDestructiveAction: true,
              onPressed: () {
                dimiss();
                retry(context);
              },
            ),
        ],
      );
    });
  }

  Future<T?> showLoadingPopup<T>() {
    return showDialog<T>(
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppCard(
            constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(color: Theme.of(context).colorScheme.onSurface),
                SizedBox(height: AppDimensions.instance.padding),
                Text(
                  "Please wait amoment", 
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<T?> showNoInternetPopup<T>({void Function(BuildContext)? retry}) {
    return AwesomeAppState.useContext<T>(callback: (BuildContext context) {
      return alert<T>(
        context,
        barrierDismissible: false,
        title: "You are currently offline",
        message: "Looks like your comnnection is interrupted check network connection and retry.",
        actions: [
          AlertAction(title: "Open Settings", onPressed: openAppSettings),
          if (retry != null)
            AlertAction(
              title: "Retry",
              onPressed: () {
                dimiss();
                retry(context);
              },
            ),
        ],
      );
    });
  }

  Future<T?> showRequestPermissionPopup<T>({
    required String title,
    required String message,
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return AwesomeAppState.useContext<T>(callback: (BuildContext context) {
      return alert<T>(
        context,
        title: title,
        message: message,
        onBackground: onBackground,
        onForeground: onForeground,
        actions: <AlertAction>[
          AlertAction(
            isDefaultAction: true,
            onPressed: dimiss,
            title: "Cancel",
          ),
          AlertAction(
            isDefaultAction: true,
            onPressed: openAppSettings,
            title: "Open Settings",
          ),
        ],
      );
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? snack({required String message}) {
    return AwesomeAppState.snack(
      builder: (BuildContext context) => SnackBar(
        margin: EdgeInsets.all(AppDimensions.instance.padding),
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius))),
        content: Text(message, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }

  Future<T?> alert<T>(
    BuildContext context, {
    String? title,
    String? message,
    bool barrierDismissible = false,
    List<AlertAction> actions = const [],
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CustomAlert(
        title: title,
        message: message,
        onBackground: onBackground,
        onForeground: onForeground,
        actions: actions,
      ),
    );
  }

  void dimiss() {
    AwesomeAppState.dimiss();
  }
}
