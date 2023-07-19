part of '../constants.dart';

class AppColors extends FlutteringColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  @override
  Color get lightPrimary => Colors.lightBlue; /// theme mode (button, title)
  @override
  Color get lightSecondary => Colors.lightBlue; /// theme mode (button, title)

  @override
  Color get darkOnPrimary => white; /// text on theme mode
  @override
  Color get darkOnSecondary => white; /// text on theme mode

  LinearGradient get gradient => LinearGradient(colors: [lightPrimary, lightSecondary]);

  BoxShadow get boxShadow => BoxShadow(color: black.withOpacity(0.1), offset: const Offset(0, 8), blurRadius: 10);
}
