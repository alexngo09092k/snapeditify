part of '../constants.dart';

class AppColors extends FlutteringColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  @override
  Color get lightBackground =>const Color.fromRGBO(245, 246, 250, 1);/// background

  @override
  Color get lightPrimary => Colors.lightBlue;

  @override
  Color get lightSecondary => Colors.lightBlueAccent;

  @override
  Color get darkPrimary => Colors.lightBlue;

  @override
  Color get darkSecondary => Colors.lightBlueAccent;

  @override
  Color get darkOnPrimary => white;

  @override
  Color get darkOnSecondary => white;

  LinearGradient get gradient => LinearGradient(colors: [lightPrimary, lightSecondary]);

  BoxShadow get boxShadow => BoxShadow(
      color: black.withOpacity(0.1),
      offset: const Offset(0, 8),
      blurRadius: 10);
}
