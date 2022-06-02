part of '../constants.dart';

abstract class AppColors {
  static Color topicColor = HexColor(Cofiguration.appColor);
  static const kLightBG = Color(0xffF1F2F3);
  static const kDarkBG = Color(0xff1B1D26);
  static const kDarkBgLight = Color(0xff282D39);

  static const kGrey900 = Color(0xFF263238);
  static const kGrey600 = Color(0xFF546E7A);
  static const kGrey200 = Color(0xFFEEEEEE);
  static const kGrey400 = Color(0xFF90a4ae);

  static const kErrorRed = Color(0xFFe74c3c);
  static const kColorRed = Color(0xFFF3090B);
  static const kWhite = Colors.white;
  static const kGrey = Colors.grey;
  static const kSurfaceWhite = Color(0xFFFFFBFA);
  static const kRedColorHeart = Color(0xFFf22742);

  static ColorScheme kColorScheme = ColorScheme(
    primary: topicColor,
    secondary: topicColor.withOpacity(0.5),
    surface: kSurfaceWhite,
    background: kWhite,
    error: kErrorRed,
    onPrimary: kDarkBG,
    onSecondary: kGrey900,
    onSurface: kGrey900,
    onBackground: kGrey900,
    onError: kSurfaceWhite,
    brightness: Brightness.light,
  );

  static LinearGradient gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      topicColor,
      topicColor.withOpacity(0.5),
    ],
  );

  static get inputColor => HexColor('#F5F5F5');
  static get helperMessageIconColor => HexColor('#525BAA');
}
