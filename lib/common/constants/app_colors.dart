part of '../constants.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  final Color kWhite = const Color.fromRGBO(255, 255, 255, 1);
  final Color kBlack = const Color.fromRGBO(0, 0, 0, 1);

  final Color kBlue = const Color.fromRGBO(200, 238, 68, 1);

  final Color kBlue2 = const Color.fromRGBO(118, 158, 5, 1);

  final Color kBlue3 = const Color.fromRGBO(41, 160, 115, 1);

  final Color kOrange = const Color.fromRGBO(242, 153, 74, 1);

  final Color kFacebook = const Color.fromRGBO(87, 122, 191, 1);
  final Color kGoogle = const Color.fromRGBO(245, 245, 245, 1);
  final Color kApple = const Color.fromRGBO(240, 240, 240, 1);

  /// warning
  final Color kRed = const Color.fromRGBO(200, 0, 0, 1);

  /// DARK COLORS
  final Color darkIcon = const Color.fromRGBO(255, 255, 255, 1);
  final Color darkIconBg = const Color.fromRGBO(63, 63, 63, 1);
  final Color darkInputBg = const Color.fromRGBO(61, 61, 61, 1);
  final Color darkInputHintText = const Color.fromRGBO(136, 136, 136, 1);
  final Color darkSubTitle = const Color.fromRGBO(255, 255, 255, 1);
  final Color darkSubSubTitle = const Color.fromRGBO(136, 136, 136, 1);
  final Color darkIconTabName = const Color.fromRGBO(136, 136, 136, 1);
  final Color darkTabName = const Color.fromRGBO(255, 255, 255, 0.5);
  final Color darkScreenName = const Color.fromRGBO(255, 255, 255, 1);
  final Color darkTitle = const Color.fromRGBO(190, 190, 190, 1);
  final Color darkActive = const Color.fromRGBO(200, 238, 68, 1);
  final Color darkCard = const Color.fromRGBO(47, 51, 56, 1);
  final Color darkDivider = const Color.fromRGBO(61, 61, 61, 1);
  final Color darkBottomAppBar = const Color.fromRGBO(41, 45, 50, 1);
  final Color darkBg = const Color.fromRGBO(41, 45, 50, 1);
  final Color darkDisable = const Color.fromRGBO(61, 61, 61, 1);
  final Color darkError = const Color.fromRGBO(200, 0, 0, 1);
  final Color darkIconBgActive = const Color.fromRGBO(224, 236, 185, 1);

  /// LIGHT COLORS
  final Color lightIcon = const Color.fromRGBO(136, 136, 136, 1);
  final Color lightIconBg = const Color.fromRGBO(239, 239, 239, 1);
  final Color lightInputBg = const Color.fromRGBO(245, 245, 245, 1);
  final Color lightInputHintText = const Color.fromRGBO(136, 136, 136, 1);
  final Color lightSubTitle = const Color.fromRGBO(136, 136, 136, 1);
  final Color lightSubSubTitle = const Color.fromRGBO(136, 136, 136, 1);
  final Color lightIconTabName = const Color.fromRGBO(61, 61, 61, 1);
  final Color lightTabName = const Color.fromRGBO(0, 0, 0, 1);
  final Color lightScreenName = const Color.fromRGBO(0, 0, 0, 1);
  final Color lightTitle = const Color.fromRGBO(136, 136, 136, 1);
  final Color lightActive = const Color.fromRGBO(118, 158, 4, 1);
  final Color lightActiveBg = const Color.fromRGBO(224, 236, 185, 1);
  final Color lightCard = const Color.fromRGBO(250, 250, 250, 1);
  final Color lightDivider = const Color.fromRGBO(230, 230, 230, 1);
  final Color lightBottomAppBar = const Color.fromRGBO(255, 255, 255, 1);
  final Color lightBg = const Color.fromRGBO(255, 255, 255, 1);
  final Color lightDisable = const Color.fromRGBO(245, 245, 245, 1);
  final Color lightError = const Color.fromRGBO(200, 0, 0, 1);
  final Color lightIconBgActive = const Color.fromRGBO(224, 236, 185, 1);

  Color get randomColor => Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8);

  LinearGradient get gradient => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          darkActive,
          lightActive,
        ],
      );

  /// SnapEdit Colors
  final String blue = "#007aff";
  final String blue100 = "#edf1f9";
  final String blue200 = "#d2e6ff";
  final String blue500 = "#0051ee";
  final String blue600 = "#0d1fbd";
  final String blueAdscta = "#004de3";
  final String bluTooltip = "#0850fd";
  final String borderColor = "#f0f0f1";
}
