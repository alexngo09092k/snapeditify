import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';

class AppThemeProvider extends ThemeProvider {
  AppThemeProvider({
    super.themeMode = ThemeMode.light,
    super.locale = const Locale('en'),
  });

  @override
  void setStatusBarByTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: AppColors.instance.lightBackground,
            statusBarColor: Colors.transparent,
          ),
        );
        break;
      case ThemeMode.dark:
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(
            systemNavigationBarColor: AppColors.instance.darkBackground,
            statusBarColor: Colors.transparent,
          ),
        );
        break;
      default:
    }
  }
}
