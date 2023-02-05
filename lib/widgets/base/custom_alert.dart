// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/widgets/base/cupertino_block.dart';

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
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        if (widget.onForeground != null) widget.onForeground!();
        break;
      case AppLifecycleState.inactive:
        if (widget.onBackground != null) widget.onBackground!();
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoBlock(
      child: CupertinoAlertDialog(
        title: widget.title != null ? Text(widget.title!, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600)) : null,
        content: widget.message != null ? Text(widget.message!, style: Theme.of(context).textTheme.bodyLarge) : null,
        actions: widget.actions
            .map((e) => CupertinoDialogAction(
                  onPressed: e.onPressed,
                  isDefaultAction: e.isDefaultAction,
                  isDestructiveAction: e.isDestructiveAction,
                  textStyle: e.textStyle,
                  child: Text(
                    e.title,
                    style: e.textStyle,
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
