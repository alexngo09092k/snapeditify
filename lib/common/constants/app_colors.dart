part of '../constants.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  final Color primaryColor = const Color.fromRGBO(109, 124, 238, 1);

  final Color secondaryColor = const Color.fromRGBO(113, 184, 205, 1);

  final Color black = const Color.fromRGBO(0, 0, 0, 1);

  final Color white = Colors.white;

  final Color errorColor = Colors.red[700]!;

  final Color textColor = const Color.fromRGBO(86, 74, 87, 1);

  LinearGradient get gradient => LinearGradient(colors: [primaryColor, secondaryColor]);

  BoxShadow get boxShadow => BoxShadow(color: black.withOpacity(0.1), offset: const Offset(0, 8), blurRadius: 10);
}
