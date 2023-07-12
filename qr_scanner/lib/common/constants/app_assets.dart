part of '../constants.dart';

///APP IMAGES
class AppAssets {
  static final AppAssets _instance = AppAssets._internal();
  static AppAssets get instance => _instance;

  factory AppAssets() => _instance;

  AppAssets._internal();

  /// Lotties
  static const String lottiePath = 'assets/lotties';

  final String auToAIAnim = '$lottiePath/autoai_anim.json';
  final String brushAnim = '$lottiePath/brush_anim.json';
  final String enhanceGuideBfAf = '$lottiePath/enhance_guide_bf_af.json';
  final String heartTeam = "$lottiePath/heart.json";
  final String notFound = "$lottiePath/not_found.json";
  final String confetti = "$lottiePath/confetti.json";

  /// Images
  static const String imagePath = 'assets/images';

  final String imagePlaceholder = "$imagePath/image_place_holder.png";
  final String logo = "$imagePath/logo.png";
  final String placeholder = "$imagePath/placeholder.png";

  /// Flags
  static const String flagPath = '$imagePath/flags';

  /// Icons
  static const String iconPath = '$imagePath/icons';

  final String icFlashOff = "$iconPath/flash-off.png";
  final String icFlashOn = "$iconPath/flash-on.png";
  final String icFlipCamera = "$iconPath/flip-camera.png";
  final String icGallery = "$iconPath/gallery.png";
  final String icGenerate = "$iconPath/generate.png";
  final String icHistory = "$iconPath/history.png";
  final String icScanner = "$iconPath/scanner.png";
  final String icSettings = "$iconPath/settings.png";
  final String icZoomIn = "$iconPath/zoom-in.png";
  final String icZoomOut = "$iconPath/zoom-out.png";
}
