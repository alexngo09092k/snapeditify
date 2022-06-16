part of '../constants.dart';

abstract class AppColors {
  static Color topicColor = HexColor(Cofiguration.appConfig.primaryColor);
  static const kDarkBG = Color(0xff1B1D26);
  static const kDarkBgLight = Color(0xff282D39);

  static const kTeal50 = Color(0xFFE0F2F1);

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
      HexColor(Cofiguration.appConfig.primaryColor),
      HexColor(Cofiguration.appConfig.secondaryColor),
    ],
  );

  static get inputColor => HexColor('#F5F5F5');
  static get helperMessageIconColor => HexColor('#525BAA');
}
