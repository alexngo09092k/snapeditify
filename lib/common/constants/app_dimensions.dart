part of '../constants.dart';

class AppDimensions {
  static final AppDimensions _instance = AppDimensions._internal();
  static AppDimensions get instance => _instance;

  factory AppDimensions() => _instance;

  AppDimensions._internal();

  /// FONT SIZE
  final double fontsize = 14;

  double fontsizeX(double x) => fontsize * x;

  final double fontSizeExtraSmall = 10;
  final double fontSizeSmall = 12;
  final double fontSizeDefault = 14;
  final double fontSizeLarge = 16;
  final double fontSizeExtraLarge = 20;
  final double fontSizeOverLarge = 24;

  /// PADDING
  final double padding = 14;

  double paddingX(double x) => padding * x;

  final double paddingSizeExtraSmall = 4.0;
  final double paddingSizeSmall = 10.0;
  final double paddingSizeLarge = 20.0;
  final double paddingSizeExtraLarge = 25.0;

  /// RADIUS

  final double radius = 10;
  double radiusX(double x) => radius * x;

  final double radiusExtraSmall = 4;
  final double radiusSmall = 8;
  final double radiusLarge = 20.0;
  final double radiusExtraLarge = 40.0;

  /// ICON
  final double icon = 32;
  double iconX(double x) => icon * x;

  final double iconSizeExtraSmall = 16;
  final double iconSizeSmall = 20;
  final double iconSizeDefault = 24;
  final double iconSizeLarge = 40;

  /// POPUP
  final double popup = 300;
  double popupX(double x) => popup * x;
}
