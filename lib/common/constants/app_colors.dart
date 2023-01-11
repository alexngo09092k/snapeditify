part of '../constants.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  /// [ACTIVE]
  final Color mediumSlateBlue = const Color.fromRGBO(108, 118, 241, 1);

  /// [ACTIVE]
  final Color downy = const Color.fromRGBO(114, 213, 187, 1);

  /// [TEXT]
  final Color black = const Color.fromRGBO(0, 0, 0, 1);

  /// [TEXT]
  final Color darkLiver = const Color.fromRGBO(86, 74, 87, 1);

  /// [BUTTON]
  final Color white = Colors.white;

  /// [BUTTON]
  LinearGradient get gradient => LinearGradient(colors: [mediumSlateBlue, downy]);

  /// [SHADOW]
  BoxShadow get boxShadow => BoxShadow(color: black.withOpacity(0.1), offset: const Offset(0, 8), blurRadius: 10);
}
