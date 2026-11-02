part of '../theme.dart';

TextTheme buildTextTheme(
  TextTheme base, {
  String fontFamily = 'Inter',
  String fontHeader = 'Inter',
  double scale = 1,
}) {
  final fs = AppDimensions.instance.fontsize;

  return base.copyWith(
    displayLarge: base.displayLarge!.copyWith(
      fontFamily: fontHeader,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      height: 1.2,
    ),
    displayMedium: base.displayMedium!.copyWith(
      fontFamily: fontHeader,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      height: 1.2,
    ),
    displaySmall: base.displaySmall!.copyWith(
      fontFamily: fontHeader,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      height: 1.25,
    ),
    headlineLarge: base.headlineLarge!.copyWith(
      fontFamily: fontHeader,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      height: 1.25,
    ),
    headlineMedium: base.headlineMedium!.copyWith(
      fontFamily: fontHeader,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      height: 1.3,
    ),
    headlineSmall: base.headlineSmall!.copyWith(
      fontFamily: fontHeader,
      fontWeight: FontWeight.w600,
      fontSize: fs * 1.35 * scale,
      letterSpacing: -0.15,
      height: 1.3,
    ),
    titleLarge: base.titleLarge!.copyWith(
      fontFamily: fontFamily,
      fontSize: fs * 1.2 * scale,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
      height: 1.35,
    ),
    titleMedium: base.titleMedium!.copyWith(
      fontFamily: fontFamily,
      fontSize: fs * 1.05 * scale,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.35,
    ),
    titleSmall: base.titleSmall!.copyWith(
      fontFamily: fontFamily,
      fontSize: fs * scale,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      height: 1.35,
    ),
    bodyLarge: base.bodyLarge!.copyWith(
      fontFamily: fontFamily,
      fontSize: fs * scale,
      fontWeight: FontWeight.w400,
      height: 1.45,
      letterSpacing: 0.1,
    ),
    bodyMedium: base.bodyMedium!.copyWith(
      fontFamily: fontFamily,
      fontSize: fs * 0.9 * scale,
      fontWeight: FontWeight.w400,
      height: 1.45,
      letterSpacing: 0.1,
    ),
    bodySmall: base.bodySmall!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: fs * 0.8 * scale,
      height: 1.4,
      letterSpacing: 0.15,
    ),
    labelLarge: base.labelLarge!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: fs * 0.95 * scale,
      letterSpacing: 0.15,
      height: 1.3,
    ),
    labelMedium: base.labelMedium!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: fs * 0.85 * scale,
      letterSpacing: 0.2,
      height: 1.3,
    ),
    labelSmall: base.labelSmall!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: fs * 0.75 * scale,
      letterSpacing: 0.25,
      height: 1.25,
    ),
  );
}
