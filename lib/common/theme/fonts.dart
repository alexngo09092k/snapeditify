part of '../theme.dart';

TextTheme buildTextTheme(
  TextTheme base, [
  String fontFamily = 'Inter',
  String fontHeader = 'Inter',
]) {
  return base
      .copyWith(
        headline1: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headline1!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        headline2: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headline1!.copyWith(fontWeight: FontWeight.w700),
        ),
        headline3: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headline3!.copyWith(fontWeight: FontWeight.w700),
        ),
        headline4: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headline4!.copyWith(fontWeight: FontWeight.w700),
        ),
        headline5: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headline5!.copyWith(fontWeight: FontWeight.w500),
        ),
        headline6: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headline6!.copyWith(fontSize: 18.0),
        ),
        subtitle1: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.subtitle1!.copyWith(
              fontSize: AppDimensions.fontSizeLarge,
              fontWeight: FontWeight.w500),
        ),
        subtitle2: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.subtitle2!.copyWith(
            fontSize: AppDimensions.fontSizeDefault,
            fontWeight: FontWeight.w500,
          ),
        ),
        bodyText1: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.bodyText1!.copyWith(
            fontSize: AppDimensions.fontSizeDefault,
            fontWeight: FontWeight.normal,
          ),
        ),
        bodyText2: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.bodyText2!.copyWith(
            fontSize: AppDimensions.fontSizeSmall,
            fontWeight: FontWeight.normal,
          ),
        ),
        caption: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.caption!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: AppDimensions.fontSizeExtraSmall,
          ),
        ),
        button: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.button!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: AppDimensions.fontSizeDefault,
          ),
        ),
      )
      .apply(
        displayColor: AppColors.kGrey900,
        bodyColor: AppColors.kGrey900,
      );
}
