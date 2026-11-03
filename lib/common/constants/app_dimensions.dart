part of '../constants.dart';

class AppDimensions {
  static final AppDimensions _instance = AppDimensions._internal();
  static AppDimensions get instance => _instance;

  factory AppDimensions() => _instance;

  AppDimensions._internal();

  /// FONT SIZE
  final double fontsize = 14;
  double fontsizeX(double x) => fontsize * x;

  /// PADDING — a bit more breathing room
  final double padding = 18;
  double paddingX(double x) => padding * x;

  /// RADIUS — soft, modern rounded
  final double radius = 18;
  double radiusX(double x) => radius * x;

  /// ICON
  final double icon = 24;
  double iconX(double x) => icon * x;

  /// GRID DELEGATE — slightly more spacing for airy feel
  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 12.0,
    mainAxisSpacing: 12.0,
  );

  Size get gridItemSize => Size(
        (AwesomeAppState.screen.width - gridDelegate.crossAxisSpacing * 3) /
            gridDelegate.crossAxisCount,
        (AwesomeAppState.screen.width - gridDelegate.crossAxisSpacing * 3) /
            gridDelegate.crossAxisCount,
      );

  double get contentMaxWidth => AwesomeAppState.screen.width - padding * 2;
}
