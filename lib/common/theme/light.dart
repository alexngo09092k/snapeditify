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
    sliderTheme: base.sliderTheme.copyWith(
      trackHeight: 1,
      trackShape: const RoundedRectSliderTrackShape(),
      activeTrackColor: base.textTheme.bodyText1!.color,
      inactiveTrackColor: base.highlightColor,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 14.0,
        pressedElevation: 8.0,
      ),
      thumbColor: base.textTheme.bodyText1!.color,
      overlayColor: Colors.transparent,
      tickMarkShape: const RoundSliderTickMarkShape(),
      activeTickMarkColor: base.textTheme.bodyText1!.color,
      inactiveTickMarkColor: Colors.white,
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: base.textTheme.bodyText1!.color,
      valueIndicatorTextStyle: base.textTheme.bodyText1!.copyWith(color: AppColors.kWhite),
    ),
  );
}
