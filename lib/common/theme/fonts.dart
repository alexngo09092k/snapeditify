part of '../theme.dart';

TextTheme buildTextTheme(
  TextTheme base, {
  String fontFamily = 'Open Sans',
  String fontHeader = 'Open Sans',
  double scale = 1,
}) {
  return base.copyWith(
    headline1: base.headline1!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    headline2: base.headline1!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    headline3: base.headline3!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    headline4: base.headline4!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
    ),
    headline5: base.headline5!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: AppDimensions.instance.fontSizeOverLarge * scale,
    ),
    headline6: base.headline6!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontSizeExtraLarge * scale,
    ),
    subtitle1: base.subtitle1!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontSizeLarge * scale,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: base.subtitle2!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontSizeDefault * scale,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: base.bodyText1!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontSizeDefault * scale,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: base.bodyText2!.copyWith(
      fontFamily: fontFamily,
      fontSize: AppDimensions.instance.fontSizeSmall * scale,
      fontWeight: FontWeight.normal,
    ),
    caption: base.caption!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: AppDimensions.instance.fontSizeExtraSmall * scale,
    ),
    button: base.button!.copyWith(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: AppDimensions.instance.fontSizeDefault * scale,
    ),
  );
}
