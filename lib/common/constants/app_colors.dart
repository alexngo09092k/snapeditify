part of '../constants.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  /// SnapEdit Colors
  final Color blue = const Color.fromRGBO(0, 122, 255, 1);
  final Color blue600 = const Color.fromRGBO(13, 31, 189, 1);
  final Color blue500 = const Color.fromRGBO(0, 81, 238, 1);
  final Color blue200 = const Color.fromRGBO(210, 230, 255, 1);
  final Color blue100 = const Color.fromRGBO(237, 241, 249, 1);
  final Color blueAdscta = const Color.fromRGBO(0, 77, 227, 1);
  final Color bluTooltip = const Color.fromRGBO(8, 80, 253, 1);
  final Color borderColor = const Color.fromRGBO(240, 240, 241, 1);
  final Color bgEnhanceResult = const Color.fromRGBO(37, 38, 56, 1);
  final Color bgImgResultOutput = const Color.fromRGBO(102, 37, 38, 1);
  final Color black = const Color.fromRGBO(37, 38, 56, 1);
  final Color black500 = const Color.fromRGBO(37, 38, 56, 1);
  final Color brand = const Color.fromRGBO(37, 38, 56, 1);
}
