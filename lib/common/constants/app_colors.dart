part of '../constants.dart';

abstract class AppColors {
  static const Color p1 = Color(0xFF030C1D);
  static const Color p2 = Color(0xFF24243E);
  static const Color p3 = Color(0xFF343B69);
  static const Color p4 = Color(0xFF525BAA);
  static const Color p5 = Color(0xFFBFC3F0);
  static const Color p6 = Color(0xFFF0F0F8);
  static const Color orange = Color(0xFFFFC000);
  static const Color green = Color(0xFF12DA9E);
  static const Color blue = Color.fromARGB(255, 44, 61, 218);
  static const Color red = Color(0xFFFE695E);
  static const Color lightGreen = Color(0xFF12DA32);
  static const Color lightYellow = Color(0xFFF4FFAD);
  static const Color darkBlue = Color.fromARGB(255, 23, 41, 200);
  static const Color placeholder = Color(0xFFF5F5F5);
  static const Color secondaryText = Color(0xFF616161);
  static const Color secondaryBg = Color(0xFFF5F5F5);
  static const Color border = Color(0xFFE0E0E0);
  static const Color disable = Color(0xFFC7C7C7);

  static const kLightBG = Colors.white;
  static const kDarkBG = Color(0xff1B1D26);
  static const kDarkBgLight = Color(0xff282D39);
  static const kWhite = Colors.white;
  static const kGrey = Colors.grey;

  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF6C76F1),
      Color(0xFF72D5BB),
    ],
  );

  static get inputColor => HexColor('#F5F5F5');
  static get helperMessageIconColor => HexColor('#525BAA');
}
