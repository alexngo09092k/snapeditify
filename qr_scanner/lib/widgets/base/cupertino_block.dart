import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';

class CupertinoBlock extends StatelessWidget {
  const CupertinoBlock({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: ManagerProvider.of<ThemeProvider>().brightness,
        barBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: Theme.of(context).primaryColor,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          actionTextStyle: Theme.of(context).textTheme.bodyLarge,
          navActionTextStyle: Theme.of(context).textTheme.bodyLarge,
          navLargeTitleTextStyle: Theme.of(context).textTheme.bodyLarge,
          navTitleTextStyle: Theme.of(context).textTheme.bodyLarge,
          pickerTextStyle: Theme.of(context).textTheme.bodyLarge,
          dateTimePickerTextStyle: Theme.of(context).textTheme.bodyLarge,
        ),
        primaryColor: Theme.of(context).primaryColor,
        primaryContrastingColor: Theme.of(context).primaryColor,
      ),
      child: child,
    );
  }
}
