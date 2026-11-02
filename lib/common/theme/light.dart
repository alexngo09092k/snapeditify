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

  final textTheme = buildTextTheme(base.textTheme, scale: scale).apply(
    bodyColor: AppColors.lightInk,
    displayColor: AppColors.lightInk,
    decorationColor: AppColors.lightInk,
  );

  final colorScheme = ColorScheme.light(
    primary: AppColors.brand,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFE8E9FF),
    onPrimaryContainer: const Color(0xFF1E1B4B),
    secondary: AppColors.accent,
    onSecondary: const Color(0xFF083344),
    secondaryContainer: const Color(0xFFCFFAFE),
    onSecondaryContainer: const Color(0xFF083344),
    surface: AppColors.lightSurf,
    onSurface: AppColors.lightInk,
    surfaceVariant: const Color(0xFFE8EAF2),
    onSurfaceVariant: const Color(0xFF4B5563),
    background: AppColors.lightBg,
    onBackground: AppColors.lightInk,
    error: const Color(0xFFEF4444),
    onError: Colors.white,
    outline: const Color(0xFFD1D5DB),
    outlineVariant: const Color(0xFFE5E7EB),
    shadow: const Color(0xFF0F172A),
  );

  return base.copyWith(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.brand,
    scaffoldBackgroundColor: AppColors.lightBg,
    canvasColor: AppColors.lightBg,
    cardColor: AppColors.lightSurf,
    dividerColor: colorScheme.outlineVariant,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    colorScheme: colorScheme,
    splashColor: AppColors.brand.withOpacity(0.08),
    highlightColor: AppColors.brand.withOpacity(0.05),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0.5,
      backgroundColor: AppColors.lightBg,
      foregroundColor: AppColors.lightInk,
      centerTitle: true,
      titleTextStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.lightInk,
      ),
      iconTheme: IconThemeData(
        color: AppColors.lightInk,
        size: AppDimensions.instance.icon,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.lightSurf,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.6)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.brand,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.brand,
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.brand,
        side: BorderSide(color: AppColors.brand.withOpacity(0.45)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.brand,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.lightSurf,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      contentTextStyle: textTheme.bodyMedium,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.lightSurf,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF3F4F8),
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
        borderSide: const BorderSide(color: AppColors.brand, width: 1.4),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: const Color(0xFF9CA3AF)),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFEEF0F8),
      selectedColor: AppColors.brand.withOpacity(0.14),
      labelStyle: textTheme.labelMedium!,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide.none,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      iconColor: AppColors.lightInk.withOpacity(0.75),
      textColor: AppColors.lightInk,
      titleTextStyle: textTheme.titleSmall,
      subtitleTextStyle: textTheme.bodySmall?.copyWith(color: const Color(0xFF6B7280)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.outlineVariant.withOpacity(0.7),
      thickness: 1,
      space: 1,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.brand,
      linearTrackColor: Color(0xFFE5E7EB),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFF1F2937),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: IconThemeData(
      color: AppColors.lightInk.withOpacity(0.88),
      size: AppDimensions.instance.icon,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurf,
      selectedItemColor: AppColors.brand,
      unselectedItemColor: const Color(0xFF9CA3AF),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: textTheme.labelSmall,
      unselectedLabelStyle: textTheme.labelSmall,
    ),
  );
}
