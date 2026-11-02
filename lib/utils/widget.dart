import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';

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
          AlertAction(
              title: S.of(context).cancel,
              onPressed: Navigator.of(context).pop),
          if (retry != null)
            AlertAction(
              title: S.of(context).retry,
              // isDestructiveAction: true,
              onPressed: () {
                dismiss();
                retry(context);
              },
            ),
        ],
      );
    });
  }

  Future<T?> showNoInternetPopup<T>({void Function(BuildContext)? retry}) {
    return AwesomeAppState.useContext<T>(callback: (BuildContext context) {
      return alert<T>(
        context,
        barrierDismissible: false,
        title: S.of(context).youAreCurrentlyOffline,
        message: S
            .of(context)
            .looksLikeYourComnnectionIsInterruptedCheckNetworkConnectionAnd,
        // onForeground: retry != null ? () => retry(context) : null,
        actions: [
          AlertAction(
              title: S.of(context).openSettings, onPressed: openAppSettings),
          if (retry != null)
            AlertAction(
              title: S.of(context).retry,
              onPressed: () {
                dismiss();
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
            onPressed: dismiss,
            title: S.of(context).cancel,
          ),
          AlertAction(
            isDefaultAction: true,
            onPressed: openAppSettings,
            title: S.of(context).openSettings,
          ),
        ],
      );
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? snack(
      {required String message}) {
    return AwesomeAppState.snack(
      builder: (BuildContext context) => SnackBar(
        margin: EdgeInsets.all(AppDimensions.instance.padding),
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimensions.instance.radius,
            ),
          ),
        ),
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

  void dismiss() {
    AwesomeAppState.dismiss();
  }
}
