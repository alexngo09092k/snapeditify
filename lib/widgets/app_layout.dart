import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    this.screen,
    this.children = const [],
    this.leading,
    this.center,
    this.action,
    this.back = false,
    this.appBar = false,
    this.useSafeArea = true,
    this.onBack,
    this.scaffoldKey,
    this.scroll = true,
    this.padding,
    this.end,
  });

  final String? screen;
  final bool appBar;
  final List<Widget> children;
  final Widget? leading;
  final Widget? center;
  final Widget? action;
  final Widget? end;
  final bool back;
  final bool useSafeArea;
  final void Function()? onBack;
  final Key? scaffoldKey;
  final bool scroll;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        bottom: useSafeArea,
        top: useSafeArea,
        left: useSafeArea,
        right: useSafeArea,
        child: Column(
          children: [
            if (appBar || back)
              _AppBar(
                back: back,
                center: center ??
                    Text(
                      screen ?? "",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                action: action,
                leading: leading,
                onBack: onBack,
              ),
            if (scroll)
              Expanded(
                child: SingleChildScrollView(
                  padding: padding,
                  child: Column(
                    children: children,
                  ),
                ),
              ),
            if (!scroll) ...children,
            if (end != null) end!,
          ],
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
      Navigator.pop(context);
      if (onBack != null) onBack!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.instance.padding),
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
                          child: Image.asset(
                            AppAssets.instance.icBack,
                            width: AppDimensions.instance.icon,
                            height: AppDimensions.instance.icon,
                          ),
                        ),
                      )
                    : (leading ?? const SizedBox()),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [center != null ? center! : const SizedBox()],
            ),
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
