part of '../constants.dart';

class AppColors extends FlutteringColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  // Brand palette (modern)
  static const Color brand = Color(0xFF5B5CF0);
  static const Color brandSoft = Color(0xFF818CF8);
  static const Color accent = Color(0xFF22D3EE);

  static const Color lightBg = Color(0xFFF4F5FA);
  static const Color lightSurf = Color(0xFFFFFFFF);
  static const Color lightInk = Color(0xFF111827);

  static const Color darkBg = Color(0xFF0B0D14);
  static const Color darkSurf = Color(0xFF161A24);
  static const Color darkInk = Color(0xFFF9FAFB);

  @override
  Color get darkOnPrimary => white;
  @override
  Color get darkOnSecondary => white;

  @override
  LinearGradient get gradient => const LinearGradient(
        colors: [Color(0xFF5B5CF0), Color(0xFF22D3EE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get heroGradient => const LinearGradient(
        colors: [Color(0xFF5B5CF0), Color(0xFFA855F7), Color(0xFF22D3EE)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  BoxShadow get boxShadow => BoxShadow(
        color: const Color(0xFF0F172A).withOpacity(0.08),
        offset: const Offset(0, 8),
        blurRadius: 24,
        spreadRadius: -4,
      );

  BoxShadow get softShadow => BoxShadow(
        color: const Color(0xFF0F172A).withOpacity(0.06),
        offset: const Offset(0, 4),
        blurRadius: 16,
        spreadRadius: -2,
      );
}
