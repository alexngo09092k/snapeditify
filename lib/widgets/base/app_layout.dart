import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    this.screen,
    this.children = const [],
    this.leading,
    this.center,
    this.action,
    this.back = true,
    this.appBar = false,
    this.useSafeArea = true,
    this.goBack,
    this.onWillPop,
    this.scaffoldKey,
    this.scroll = false,
    this.padding,
    this.before,
    this.after,
    this.decoration,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final String? screen;
  final bool appBar;
  final List<Widget> children;
  final Widget? leading;
  final Widget? center;
  final Widget? action;
  final Widget? before;
  final Widget? after;
  final bool back;
  final bool useSafeArea;
  final void Function()? goBack;
  final Future<bool> Function()? onWillPop;
  final Key? scaffoldKey;
  final bool scroll;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: decoration,
          child: SafeArea(
            bottom: useSafeArea,
            top: useSafeArea,
            left: useSafeArea,
            right: useSafeArea,
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              children: [
                if (appBar || back)
                  _AppBar(
                    back: back,
                    center: center ??
                        (screen != null
                            ? Text(
                                screen!,
                                style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w600),
                                maxLines: 1,
                              )
                            : null),
                    action: action,
                    leading: leading,
                    onBack: goBack,
                  ),
                if (before != null) before!,
                if (scroll)
                  Expanded(
                    child: SingleChildScrollView(
                      padding: padding,
                      child: Column(
                        children: children,
                      ),
                    ),
                  ),
                if (!scroll)
                  Expanded(
                    child: Container(
                      padding: padding,
                      child: Column(
                        children: children,
                      ),
                    ),
                  ),
                if (after != null) after!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({this.back = false, this.center, this.action, this.leading, this.onBack});
  final bool back;
  final Widget? leading;
  final Widget? action;
  final Widget? center;
  final void Function()? onBack;

  void _canBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      if (onBack != null) {
        onBack!();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.instance.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                back
                    ? GestureDetector(
                        onTap: () => _canBack(context),
                        child: Container(
                          padding: EdgeInsets.only(
                            right: AppDimensions.instance.padding,
                            left: AppDimensions.instance.padding,
                          ),
                          color: Colors.transparent,
                          child: const CustomIcon(CupertinoIcons.back),
                        ),
                      )
                    : (leading ?? const SizedBox()),
              ],
            ),
          ),
          if (center != null)
            Expanded(
              child: Center(child: center!),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [action ?? const SizedBox()],
            ),
          )
        ],
      ),
    );
  }
}
