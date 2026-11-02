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
  final double padding = 16;
  double paddingX(double x) => padding * x;

  /// RADIUS — modern, softer corners
  final double radius = 16;
  double radiusX(double x) => radius * x;

  /// ICON
  final double icon = 24;
  double iconX(double x) => icon * x;

  /// GRID DELEGATE
  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
  );

  Size get gridItemSize => Size(
        (AwesomeAppState.screen.width - gridDelegate.crossAxisSpacing * 3) /
            gridDelegate.crossAxisCount,
        (AwesomeAppState.screen.width - gridDelegate.crossAxisSpacing * 3) /
            gridDelegate.crossAxisCount,
      );

  double get contentMaxWidth => AwesomeAppState.screen.width - padding * 2;
}
