part of '../theme.dart';

ThemeData getLightTheme(BuildContext context) {
  final base = ThemeData.light().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  return base.copyWith(
    textTheme: base.textTheme,
    primaryTextTheme: base.primaryTextTheme,
    primaryColor: base.primaryColor,
    secondaryHeaderColor: base.secondaryHeaderColor,
    backgroundColor: AppColors.kLightBG,
    brightness: Brightness.dark,
    cardColor: base.cardColor,
    textButtonTheme: base.textButtonTheme,
    colorScheme: base.colorScheme,
    snackBarTheme: base.snackBarTheme,
    indicatorColor: base.indicatorColor,
    progressIndicatorTheme: base.progressIndicatorTheme,
    canvasColor: base.canvasColor,
    primaryColorLight: base.primaryColorLight,
    scaffoldBackgroundColor: AppColors.kLightBG,
    appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: AppColors.kLightBG, shadowColor: null, elevation: 0),
    buttonTheme: base.buttonTheme,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    tabBarTheme: base.tabBarTheme,
    bottomAppBarColor: base.bottomAppBarColor,
    disabledColor: base.disabledColor,
    cardTheme: base.cardTheme,
    primaryIconTheme: base.primaryIconTheme,
    iconTheme: base.iconTheme,
  );
}
