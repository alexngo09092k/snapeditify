part of '../constants.dart';

class AppDimensions {
  static final AppDimensions _instance = AppDimensions._internal();
  static AppDimensions get instance => _instance;

  factory AppDimensions() => _instance;

  AppDimensions._internal();

  /// FONT SIZE
  final double fontSizeExtraSmall = 10;
  final double fontSizeSmall = 12;
  final double fontSizeDefault = 14;
  final double fontSizeLarge = 16;
  final double fontSizeExtraLarge = 20;
  final double fontSizeOverLarge = 24;

  /// PADDING
  final double paddingSizeExtraSmall = 4.0;
  final double paddingSizeSmall = 10.0;
  final double paddingSizeDefault = 16;
  final double paddingSizeLarge = 20.0;
  final double paddingSizeExtraLarge = 25.0;

  /// RADIUS
  final double radiusExtraSmall = 4;
  final double radiusSmall = 8;
  final double radiusDefault = 10;
  final double radiusLarge = 20.0;
  final double radiusExtraLarge = 40.0;

  /// ICON
  final double iconSizeExtraSmall = 16;
  final double iconSizeSmall = 20;
  final double iconSizeDefault = 24;
  final double iconSizeLarge = 40;
}
