part of '../theme.dart';

TextTheme buildTextTheme(
  TextTheme base, {
  String fontFamily = 'Inter',
  String fontHeader = 'Inter',
  double scale = 1,
}) {
  return base.copyWith(
    displayLarge: base.displayLarge!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: base.displayMedium!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: base.displaySmall!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: base.headlineMedium!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: base.headlineSmall!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: AppDimensions.instance.fontsizeX(1.4) * scale,
    ),
    titleLarge: base.titleLarge!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontsizeX(1.3) * scale,
    ),
    titleMedium: base.titleMedium!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontsizeX(1.2) * scale,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: base.titleSmall!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontsizeX(1.1) * scale,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: base.bodyLarge!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontsizeX(1) * scale,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: base.bodyMedium!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontsizeX(0.8) * scale,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: base.bodySmall!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: AppDimensions.instance.fontsizeX(0.7) * scale,
    ),
    labelLarge: base.labelLarge!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: AppDimensions.instance.fontsizeX(1) * scale,
    ),
  );
}
