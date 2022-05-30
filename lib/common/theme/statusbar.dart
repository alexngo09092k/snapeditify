part of '../theme.dart';

/// Changes the text and icon color on the statusbar to a dark color
void setDarkStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(getDarkStatusBar());
}

/// Changes the text and icon color on the statusbar to a light color
void setLightStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(getLightStatusBar());
}

SystemUiOverlayStyle getLightStatusBar() => const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.kDarkBG,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );

SystemUiOverlayStyle getDarkStatusBar() => const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.kLightBG,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );
