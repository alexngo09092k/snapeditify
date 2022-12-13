part of '../constants.dart';

class AppDimensions {
  static final AppDimensions _instance = AppDimensions._internal();
  static AppDimensions get instance => _instance;

  factory AppDimensions() => _instance;

  AppDimensions._internal();

  /// FONT SIZE
  final double fontsize = 14;
  double fontsizeX(double x) => fontsize * x;

  /// PADDING
  final double padding = 14;
  double paddingX(double x) => padding * x;

  /// RADIUS

  final double radius = 10;
  double radiusX(double x) => radius * x;

  /// ICON
  final double icon = 32;
  double iconX(double x) => icon * x;

  /// POPUP
  final double popup = 300;
  double popupX(double x) => popup * x;
}
