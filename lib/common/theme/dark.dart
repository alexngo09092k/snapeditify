part of '../theme.dart';

ThemeData getDarkTheme(BuildContext context) {
  final base = ThemeData.dark().copyWith(
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
    backgroundColor: base.backgroundColor,
    brightness: Brightness.dark,
    cardColor: base.cardColor,
    textButtonTheme: base.textButtonTheme,
    colorScheme: base.colorScheme,
    snackBarTheme: base.snackBarTheme,
    indicatorColor: base.indicatorColor,
    progressIndicatorTheme: base.progressIndicatorTheme,
    canvasColor: base.canvasColor,
    primaryColorLight: base.primaryColorLight,
    scaffoldBackgroundColor: base.scaffoldBackgroundColor,
    appBarTheme: base.appBarTheme,
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
