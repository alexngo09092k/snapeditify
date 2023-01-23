// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert({super.key, this.onBackground, this.onForeground, this.message, this.title, this.actions = const []});
  final void Function()? onBackground;
  final void Function()? onForeground;
  final String? title;
  final String? message;
  final List<AlertAction> actions;

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        if (widget.onBackground != null) widget.onBackground!();
        break;
      case AppLifecycleState.inactive:
        if (widget.onForeground != null) widget.onForeground!();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        barBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: CupertinoAlertDialog(
        title: widget.title != null
            ? Text(
                widget.title!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
              )
            : null,
        content: widget.message != null ? Text(widget.message!, style: Theme.of(context).textTheme.bodyText2!.copyWith()) : null,
        actions: widget.actions
            .map((e) => CupertinoDialogAction(
                  onPressed: e.onPressed,
                  isDefaultAction: e.isDefaultAction,
                  isDestructiveAction: e.isDestructiveAction,
                  textStyle: e.textStyle,
                  child: Text(
                    e.title,
                    style: e.textStyle ?? Theme.of(context).textTheme.bodyText1,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class AlertAction {
  void Function()? onPressed;
  bool isDefaultAction;
  bool isDestructiveAction;
  TextStyle? textStyle;
  String title;

  AlertAction({
    this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle,
    required this.title,
  });
}
