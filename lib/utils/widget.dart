import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';

class WidgetUtils {
  static final WidgetUtils _instance = WidgetUtils._internal();

  static WidgetUtils get instance => _instance;

  WidgetUtils._internal();

  Future<T?> showErrorPopup<T>(
    BuildContext context, {
    String? title,
    String? message,
    Function(BuildContext)? retry,
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return alert<T>(
      context,
      title: title ?? S.of(context).somethingWrongs,
      message: message ?? S.of(context).somethingsWrongPleaseTryAgain,
      onBackground: onBackground,
      onForeground: onForeground,
      actions: [
        AlertAction(title: S.of(context).cancel, onPressed: Navigator.of(context).pop),
        if (retry != null)
          AlertAction(
            title: S.of(context).retry,
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              retry(context);
            },
          ),
      ],
    );
  }

  Future<T?> showLoadingPopup<T>(BuildContext context, {String? message}) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppCard(
            constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
            color: AppColors.instance.black.withOpacity(0.5),
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(
                  color: AppColors.instance.white,
                ),
                if (message != null) SizedBox(height: AppDimensions.instance.padding),
                if (message != null)
                  Text(
                    message,
                    style: Theme.of(context).textTheme.caption!.copyWith(color: AppColors.instance.white),
                  ),
              ],
            ),
          )
        ],
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

  Future<T?> showNoInternetPopup<T>(
    BuildContext context, {
    void Function(BuildContext)? retry,
  }) {
    return alert<T>(
      context,
      title: S.of(context).youAreCurrentlyOffline,
      message: S.of(context).looksLikeYourComnnectionIsInterruptedCheckNetworkConnectionAnd,
      onForeground: () {
        Navigator.of(context).pop();
        if (retry != null) retry(context);
      },
      actions: [
        AlertAction(title: S.of(context).openSettings, onPressed: openAppSettings),
        if (retry != null)
          AlertAction(
            title: S.of(context).retry,
            onPressed: () {
              Navigator.of(context).pop();
              retry(context);
            },
          ),
      ],
    );
  }

  Future<T?> showRequestPermissionPopup<T>(
    BuildContext context, {
    required String title,
    required String message,
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return alert<T>(
      context,
      title: title,
      message: message,
      onBackground: onBackground,
      onForeground: onForeground,
      actions: <AlertAction>[
        AlertAction(
          isDefaultAction: true,
          onPressed: Navigator.of(context).pop,
          title: S.of(context).cancel,
        ),
        AlertAction(
          isDefaultAction: true,
          onPressed: openAppSettings,
          title: S.of(context).openSettings,
        ),
      ],
    );
  }
}
