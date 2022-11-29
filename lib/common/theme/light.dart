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
      bodyColor: AppColors.instance.lightTitle,
    ),

    primaryTextTheme: buildTextTheme(base.primaryTextTheme, scale: scale),

    primaryColor: AppColors.instance.lightActive,

    secondaryHeaderColor: base.secondaryHeaderColor,

    /// ================== CARD =====================
    cardColor: AppColors.instance.lightCard,

    textButtonTheme: base.textButtonTheme,

    listTileTheme: base.listTileTheme,

    /// =================== COLOR SCHEME ====================
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.instance.kBlue,
      background: AppColors.instance.kWhite,
      error: AppColors.instance.kRed,
      brightness: Brightness.dark,
    ),

    /// ====================== TEXT SELECTION THEME ======================
    textSelectionTheme: base.textSelectionTheme.copyWith(
      cursorColor: AppColors.instance.lightIcon,
    ),

    /// ====================== SNACKBAR ======================
    snackBarTheme: base.snackBarTheme.copyWith(
      backgroundColor: AppColors.instance.lightCard,
      contentTextStyle: TextStyle(
        color: AppColors.instance.lightSubTitle,
        fontSize: AppDimensions.instance.fontSizeDefault,
      ),
    ),

    /// ====================== INDICATOR ======================
    indicatorColor: AppColors.instance.lightIcon,

    progressIndicatorTheme: base.progressIndicatorTheme.copyWith(
      color: AppColors.instance.lightActive,
    ),

    canvasColor: AppColors.instance.lightBg,

    /// ====================== ACTIVE COLOR ======================
    primaryColorLight: AppColors.instance.lightActive,

    /// ====================== BACKGROUND AND DIALOG ======================
    splashColor: AppColors.instance.lightBg,
    backgroundColor: AppColors.instance.lightBg,
    dialogBackgroundColor: AppColors.instance.lightBg,
    scaffoldBackgroundColor: AppColors.instance.lightBg,

    /// ====================== STATUS BAR ======================
    appBarTheme: base.appBarTheme.copyWith(
      color: AppColors.instance.lightBg,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),

    buttonTheme: base.buttonTheme,

    tabBarTheme: base.tabBarTheme,

    /// ====================== BOTTOM APP BAR ====================
    bottomAppBarColor: AppColors.instance.lightBottomAppBar,

    /// ====================== DISABLED ====================
    disabledColor: AppColors.instance.darkDisable,

    /// ======================= CARD =======================
    cardTheme: base.cardTheme.copyWith(
      color: AppColors.instance.lightCard,
    ),

    /// ======================== ICON =======================
    iconTheme: base.iconTheme.copyWith(
      color: AppColors.instance.lightIcon,
      size: AppDimensions.instance.iconSizeDefault,
    ),

    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: AppColors.instance.lightActive,
      size: AppDimensions.instance.iconSizeDefault,
    ),

    /// ========================= INPUT ========================
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      fillColor: AppColors.instance.lightInputBg,
      filled: true,
      hintStyle: TextStyle(
        color: AppColors.instance.lightInputHintText,
        fontSize: AppDimensions.instance.fontSizeDefault,
      ),
    ),

    /// ========================= DIVIDER ========================
    dividerColor: AppColors.instance.lightDivider,
  );
}
