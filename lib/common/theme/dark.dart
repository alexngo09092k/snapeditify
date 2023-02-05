part of '../theme.dart';

ThemeData getDarkTheme(BuildContext context, {double scale = 1}) {
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
      bodyColor: AppColors.instance.textColor,
    ),

    primaryTextTheme: buildTextTheme(base.primaryTextTheme, scale: scale).apply(
      bodyColor: AppColors.instance.textColor,
    ),

    primaryColor: AppColors.instance.primaryColor,

    secondaryHeaderColor: base.secondaryHeaderColor,

    /// ================== CARD =====================
    cardColor: AppColors.instance.white,

    textButtonTheme: base.textButtonTheme,

    listTileTheme: base.listTileTheme,

    /// =================== COLOR SCHEME ====================
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.instance.primaryColor,
      secondary: AppColors.instance.secondaryColor,
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
    splashColor: AppColors.instance.white,
    dialogBackgroundColor: AppColors.instance.white,
    scaffoldBackgroundColor: AppColors.instance.white,

    /// ====================== STATUS BAR ======================
    appBarTheme: base.appBarTheme,

    buttonTheme: base.buttonTheme,

    tabBarTheme: base.tabBarTheme,

    /// ====================== DISABLED ====================
    disabledColor: AppColors.instance.textColor.withOpacity(0.5),

    /// ======================= CARD =======================
    cardTheme: base.cardTheme,

    /// ======================== ICON =======================
    iconTheme: base.iconTheme.copyWith(color: AppColors.instance.textColor),

    primaryIconTheme: base.primaryIconTheme,

    /// ========================= INPUT ========================
    inputDecorationTheme: base.inputDecorationTheme,

    /// ========================= DIVIDER ========================
    dividerColor: AppColors.instance.textColor.withOpacity(0.1),
  );
}
