part of '../constants.dart';

class AppColors extends FlutteringColors {
  static final AppColors _instance = AppColors._internal();
  static AppColors get instance => _instance;

  factory AppColors() => _instance;

  AppColors._internal();

  // Brand palette — softer, airier modern violet
  static const Color brand = Color(0xFF6C63FF);
  static const Color brandSoft = Color(0xFFA5A0FF);
  static const Color accent = Color(0xFF67E8F9);

  static const Color lightBg = Color(0xFFF7F8FC);
  static const Color lightSurf = Color(0xFFFFFFFF);
  static const Color lightInk = Color(0xFF1A1D26);

  static const Color darkBg = Color(0xFF0C0E14);
  static const Color darkSurf = Color(0xFF151922);
  static const Color darkInk = Color(0xFFF8FAFC);

  @override
  Color get darkOnPrimary => white;
  @override
  Color get darkOnSecondary => white;

  @override
  LinearGradient get gradient => const LinearGradient(
        colors: [Color(0xFF6C63FF), Color(0xFF67E8F9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get heroGradient => const LinearGradient(
        colors: [
          Color(0xFF7C74FF),
          Color(0xFF9B8CFF),
          Color(0xFF67E8F9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  /// Very soft ambient shadow — light & airy
  @override
  BoxShadow get boxShadow => BoxShadow(
        color: const Color(0xFF64748B).withOpacity(0.08),
        offset: const Offset(0, 6),
        blurRadius: 20,
        spreadRadius: -4,
      );

  BoxShadow get softShadow => BoxShadow(
        color: const Color(0xFF64748B).withOpacity(0.05),
        offset: const Offset(0, 3),
        blurRadius: 12,
        spreadRadius: -2,
      );

  BoxShadow get cardShadow => BoxShadow(
        color: const Color(0xFF64748B).withOpacity(0.07),
        offset: const Offset(0, 8),
        blurRadius: 24,
        spreadRadius: -6,
      );
}
