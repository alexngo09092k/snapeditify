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
      bodyColor: AppColors.instance.darkTitle,
    ),

    primaryTextTheme: buildTextTheme(base.primaryTextTheme, scale: scale),

    primaryColor: AppColors.instance.darkActive,

    secondaryHeaderColor: base.secondaryHeaderColor,

    /// ======================== CARD =========================
    cardColor: AppColors.instance.darkCard,

    textButtonTheme: base.textButtonTheme,

    listTileTheme: base.listTileTheme,

    errorColor: AppColors.instance.darkError,

    /// ====================== COLOR SCHEME ======================
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.instance.kBlue,
      background: AppColors.instance.darkBg,
      error: AppColors.instance.kRed,
      brightness: Brightness.light,
    ),

    /// ====================== SNACKBAR ======================
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: AppColors.instance.darkCard,
      contentTextStyle: TextStyle(
        color: AppColors.instance.darkSubTitle,
        fontSize: AppDimensions.instance.fontSizeDefault,
      ),
    ),

    /// ====================== INDICATOR ======================
    indicatorColor: AppColors.instance.darkIcon,

    progressIndicatorTheme: base.progressIndicatorTheme.copyWith(
      color: AppColors.instance.darkActive,
    ),

    canvasColor: AppColors.instance.darkBg,

    /// ====================== ACTIVE COLOR ======================
    primaryColorLight: AppColors.instance.darkActive,

    /// ====================== BACKGROUND AND DIALOG ======================
    splashColor: AppColors.instance.darkBg,
    backgroundColor: AppColors.instance.darkBg,
    dialogBackgroundColor: AppColors.instance.darkBg,
    scaffoldBackgroundColor: AppColors.instance.darkBg,

    /// ====================== TEXT SELECTION THEME ======================
    textSelectionTheme: base.textSelectionTheme.copyWith(
      cursorColor: AppColors.instance.darkIcon,
    ),

    /// ====================== STATUS BAR ======================
    appBarTheme: base.appBarTheme.copyWith(
      color: AppColors.instance.darkBg,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

    buttonTheme: base.buttonTheme,

    tabBarTheme: base.tabBarTheme,

    /// ====================== BOTTOM APP BAR ====================
    bottomAppBarColor: AppColors.instance.darkBottomAppBar,

    /// ====================== DISABLED ====================
    disabledColor: AppColors.instance.darkDisable,

    /// ======================= CARD =======================
    cardTheme: base.cardTheme.copyWith(
      color: AppColors.instance.darkCard,
    ),

    /// ======================== ICON =======================
    iconTheme: base.iconTheme.copyWith(
      color: AppColors.instance.darkIcon,
      size: AppDimensions.instance.iconSizeDefault,
    ),

    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: AppColors.instance.darkActive,
      size: AppDimensions.instance.iconSizeDefault,
    ),

    /// ========================= INPUT ========================
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      fillColor: AppColors.instance.darkInputBg,
      filled: true,
      hintStyle: TextStyle(
        color: AppColors.instance.darkInputHintText,
        fontSize: AppDimensions.instance.fontSizeDefault,
      ),
    ),

    /// ========================= DIVIDER ========================
    dividerColor: AppColors.instance.darkDivider,
  );
}
