part of '../theme.dart';

ThemeData getDarkTheme(BuildContext context, {double scale = 1}) {
  final base = ThemeData.dark().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  return base.copyWith(
    brightness: Brightness.light,

    textTheme: buildTextTheme(base.textTheme, scale: scale).apply(
      bodyColor: AppColors.instance.darkOnBackground,
      displayColor:  AppColors.instance.darkOnBackground,
      decorationColor: AppColors.instance.darkOnBackground,
    ),

    primaryTextTheme: buildTextTheme(base.primaryTextTheme, scale: scale).apply(
      bodyColor: AppColors.instance.darkOnBackground,
      displayColor:  AppColors.instance.darkOnBackground,
      decorationColor: AppColors.instance.darkOnBackground,
    ),

    primaryColor: AppColors.instance.darkPrimary,

    secondaryHeaderColor: base.secondaryHeaderColor,

    /// ================== CARD =====================
    cardColor: AppColors.instance.darkSurface,

    textButtonTheme: base.textButtonTheme,

    listTileTheme: base.listTileTheme,

    /// =================== COLOR SCHEME ====================
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.instance.darkPrimary,
      onPrimary: AppColors.instance.darkOnPrimary,
      onPrimaryContainer: AppColors.instance.darkOnPrimary,
      secondary: AppColors.instance.darkSecondary,
      onSecondary: AppColors.instance.darkOnSecondary,
      onSecondaryContainer: AppColors.instance.darkOnSecondary,
      background: AppColors.instance.darkBackground,
      onBackground: AppColors.instance.darkOnBackground,
      surface: AppColors.instance.darkSurface,
      onSurface: AppColors.instance.darkOnSurface,
      error: AppColors.instance.darkError,
      onError: AppColors.instance.darkOnError,
    ),

    /// ====================== TEXT SELECTION THEME ======================
    textSelectionTheme: base.textSelectionTheme,

    /// ====================== SNACKBAR ======================
    snackBarTheme: base.snackBarTheme,

    /// ====================== INDICATOR ======================
    indicatorColor: base.indicatorColor,

    progressIndicatorTheme: base.progressIndicatorTheme,

    canvasColor: base.canvasColor,

    /// ====================== ACTIVE COLOR ======================
    primaryColorLight: base.primaryColorLight,

    /// ====================== BACKGROUND AND DIALOG ======================
    splashColor: AppColors.instance.darkBackground,
    dialogBackgroundColor: AppColors.instance.darkSurface,
    scaffoldBackgroundColor: AppColors.instance.darkBackground,

    /// ====================== STATUS BAR ======================
    appBarTheme: base.appBarTheme,

    buttonTheme: base.buttonTheme,

    tabBarTheme: base.tabBarTheme,

    /// ====================== DISABLED ====================
    disabledColor: base.disabledColor,

    /// ======================= CARD =======================
    cardTheme: base.cardTheme,

    /// ======================== ICON =======================
    iconTheme: base.iconTheme.copyWith(
      color: AppColors.instance.darkOnBackground, 
      size: AppDimensions.instance.icon,
    ),

    primaryIconTheme: base.primaryIconTheme,

    /// ========================= INPUT ========================
    inputDecorationTheme: base.inputDecorationTheme,

    /// ========================= DIVIDER ========================
    dividerColor: base.dividerColor,
  );
}
