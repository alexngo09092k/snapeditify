import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';

class WidgetUtils {
  static final WidgetUtils _instance = WidgetUtils._internal();

  static WidgetUtils get instance => _instance;

  WidgetUtils._internal();

  showErrorPopup<T>(BuildContext context, {String? title, String? message, Function(BuildContext)? retry}) {
    return alert<T>(
      context,
      title: title ?? 'Something wrongs',
      message: message ?? 'Somethings wrong, please try again.',
      actions: [
        AlertAction(title: 'Cancel', onPressed: Navigator.of(context).pop),
        if (retry != null)
          AlertAction(
            title: 'Retry',
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              retry(context);
            },
          ),
      ],
    );
  }

  showLoadingPopup<T>(BuildContext context, {String? message}) {
    showDialog<T>(
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

  alert<T>(
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

  showNoInternetPopup<T>(
    BuildContext context, {
    required void Function()? retry,
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return alert<T>(
      context,
      title: '',
      message: '',
      onBackground: onBackground,
      onForeground: onForeground,
      actions: <AlertAction>[
        AlertAction(
          isDefaultAction: true,
          onPressed: openAppSettings,
          title: 'Open settings',
        ),
        AlertAction(
          isDefaultAction: true,
          onPressed: retry,
          title: 'Retry',
        ),
      ],
    );
  }

  showRequestPermissionPopup<T>(
    BuildContext context, {
    required String title,
    required String message,
    void Function()? onBackground,
    void Function()? onForeground,
  }) {
    return alert<T>(
      context,
      title: '',
      message: '',
      onBackground: onBackground,
      onForeground: onForeground,
      actions: <AlertAction>[
        AlertAction(
          isDefaultAction: true,
          onPressed: Navigator.of(context).pop,
          title: 'Cancel',
        ),
        AlertAction(
          isDefaultAction: true,
          onPressed: openAppSettings,
          title: 'Open settings',
        ),
      ],
    );
  }
}
