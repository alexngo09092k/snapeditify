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
    textTheme: buildTextTheme(base.textTheme),
    primaryTextTheme: buildTextTheme(base.primaryTextTheme),
    primaryColor: AppColors.topicColor,
    secondaryHeaderColor: base.secondaryHeaderColor,
    backgroundColor: AppColors.kWhite,
    brightness: Brightness.dark,
    textButtonTheme: base.textButtonTheme,
    snackBarTheme: base.snackBarTheme,
    indicatorColor: AppColors.topicColor,
    progressIndicatorTheme: base.progressIndicatorTheme,
    canvasColor: base.canvasColor,
    primaryColorLight: AppColors.kWhite,
    scaffoldBackgroundColor: AppColors.kWhite,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: AppColors.kWhite,
      shadowColor: null,
      elevation: 0,
    ),
    buttonTheme: base.buttonTheme,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    bottomAppBarColor: base.bottomAppBarColor,
    colorScheme: AppColors.kColorScheme,
    primaryIconTheme: base.primaryIconTheme.copyWith(color: AppColors.kGrey900),
    iconTheme: base.iconTheme.copyWith(color: AppColors.kGrey900),
    disabledColor: AppColors.kGrey600,
    hintColor: AppColors.kGrey600,
    cardColor: AppColors.kWhite,
  );
}
