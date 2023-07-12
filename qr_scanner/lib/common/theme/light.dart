part of '../theme.dart';

ThemeData getLightTheme(BuildContext context, {double scale = 1}) {
  final base = ThemeData.light().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  return base.copyWith(
    brightness: Brightness.dark,

    textTheme: buildTextTheme(base.textTheme, scale: scale).apply(
      bodyColor: AppColors.instance.lightOnBackground,
      displayColor:  AppColors.instance.lightOnBackground,
      decorationColor: AppColors.instance.lightOnBackground,
    ),

    primaryTextTheme: buildTextTheme(base.primaryTextTheme, scale: scale).apply(
      bodyColor: AppColors.instance.lightOnBackground,
      displayColor:  AppColors.instance.lightOnBackground,
      decorationColor: AppColors.instance.lightOnBackground,
    ),

    primaryColor: AppColors.instance.lightPrimary,

    secondaryHeaderColor: base.secondaryHeaderColor,

    /// ================== CARD =====================
    cardColor: AppColors.instance.lightSurface,

    textButtonTheme: base.textButtonTheme,

    listTileTheme: base.listTileTheme,

    /// =================== COLOR SCHEME ====================
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.instance.lightPrimary,
      onPrimary: AppColors.instance.lightOnPrimary,
      onPrimaryContainer: AppColors.instance.lightOnPrimary,
      secondary: AppColors.instance.lightSecondary,
      onSecondary: AppColors.instance.lightOnSecondary,
      onSecondaryContainer: AppColors.instance.lightOnSecondary,
      background: AppColors.instance.lightBackground,
      onBackground: AppColors.instance.lightOnBackground,
      surface: AppColors.instance.lightSurface,
      onSurface: AppColors.instance.lightOnSurface,
      error: AppColors.instance.lightError,
      onError: AppColors.instance.lightOnError,
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
    splashColor: AppColors.instance.lightBackground,
    dialogBackgroundColor: AppColors.instance.lightSurface,
    scaffoldBackgroundColor: AppColors.instance.lightBackground,

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
      color: AppColors.instance.lightOnBackground, 
      size: AppDimensions.instance.icon,
    ),

    primaryIconTheme: base.primaryIconTheme,

    /// ========================= INPUT ========================
    inputDecorationTheme: base.inputDecorationTheme,

    /// ========================= DIVIDER ========================
    dividerColor: base.dividerColor,
  );
}
