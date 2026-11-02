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

  final textTheme = buildTextTheme(base.textTheme, scale: scale).apply(
    bodyColor: AppColors.darkInk,
    displayColor: AppColors.darkInk,
    decorationColor: AppColors.darkInk,
  );

  final colorScheme = ColorScheme.dark(
    primary: AppColors.brandSoft,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFF2E3190),
    onPrimaryContainer: const Color(0xFFE0E7FF),
    secondary: AppColors.accent,
    onSecondary: const Color(0xFF083344),
    secondaryContainer: const Color(0xFF155E75),
    onSecondaryContainer: const Color(0xFFCFFAFE),
    surface: AppColors.darkSurf,
    onSurface: AppColors.darkInk,
    surfaceVariant: const Color(0xFF222633),
    onSurfaceVariant: const Color(0xFFCBD5E1),
    background: AppColors.darkBg,
    onBackground: AppColors.darkInk,
    error: const Color(0xFFF87171),
    onError: const Color(0xFF450A0A),
    outline: const Color(0xFF374151),
    outlineVariant: const Color(0xFF2A2F3A),
    shadow: Colors.black,
  );

  return base.copyWith(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.brandSoft,
    scaffoldBackgroundColor: AppColors.darkBg,
    canvasColor: AppColors.darkBg,
    cardColor: AppColors.darkSurf,
    dividerColor: colorScheme.outlineVariant,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    colorScheme: colorScheme,
    splashColor: AppColors.brandSoft.withOpacity(0.12),
    highlightColor: AppColors.brandSoft.withOpacity(0.08),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      backgroundColor: AppColors.darkBg,
      foregroundColor: AppColors.darkInk,
      centerTitle: true,
      titleTextStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.darkInk,
      ),
      iconTheme: IconThemeData(
        color: AppColors.darkInk,
        size: AppDimensions.instance.icon,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkSurf,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.8)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.brandSoft,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brandSoft,
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.brandSoft,
        side: BorderSide(color: AppColors.brandSoft.withOpacity(0.45)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.brandSoft,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurf,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      contentTextStyle: textTheme.bodyMedium,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkSurf,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1C2130),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.brandSoft, width: 1.4),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: const Color(0xFF9CA3AF)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF222633),
      selectedColor: AppColors.brandSoft.withOpacity(0.22),
      labelStyle: textTheme.labelMedium!,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide.none,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      iconColor: AppColors.darkInk.withOpacity(0.8),
      textColor: AppColors.darkInk,
      titleTextStyle: textTheme.titleSmall,
      subtitleTextStyle: textTheme.bodySmall?.copyWith(color: const Color(0xFF9CA3AF)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.outlineVariant.withOpacity(0.9),
      thickness: 1,
      space: 1,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.brandSoft,
      linearTrackColor: colorScheme.outlineVariant,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF1F2937),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: IconThemeData(
      color: AppColors.darkInk.withOpacity(0.9),
      size: AppDimensions.instance.icon,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurf,
      selectedItemColor: AppColors.brandSoft,
      unselectedItemColor: const Color(0xFF6B7280),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: textTheme.labelSmall,
      unselectedLabelStyle: textTheme.labelSmall,
    ),
  );
}
