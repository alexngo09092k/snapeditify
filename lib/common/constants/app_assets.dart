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
  final String homeArtEffectBanner = '$lottiePath/home_art_effect_banner.json';
  final String homeEnhanceBanner = '$lottiePath/home_enhance_banner.json';
  final String homeRemoveObjectBanner = '$lottiePath/home_remove_object_banner.json';
  final String homeAnimeAIBanner = '$lottiePath/home_anime_ai_banner.json';
  final String heartTeam = "$lottiePath/heart.json";
  final String premiumGold = "$lottiePath/premium_gold.json";
  final String notFound = "$lottiePath/not_found.json";
  final String confetti = "$lottiePath/confetti.json";

  /// Images
  static const String imagePath = 'assets/images';

  final String pageBackground = "$imagePath/page_background.png";
  final String logo = "$imagePath/logo.png";

  /// Suggest images
  final String removeObjectDemo1 = "$imagePath/remove_object_demo_1.jpg";
  final String removeObjectDemo2 = "$imagePath/remove_object_demo_2.jpeg";
  final String removeObjectDemo3 = "$imagePath/remove_object_demo_3.jpg";

  final String enhanceDemo1 = "$imagePath/enhance_demo_1.webp";
  final String enhanceDemo2 = "$imagePath/enhance_demo_2.webp";
  final String enhanceDemo3 = "$imagePath/enhance_demo_3.webp";

  final String restyleDemo1 = "$imagePath/restyle_demo_1.jpeg";
  final String restyleDemo2 = "$imagePath/restyle_demo_2.jpeg";
  final String restyleDemo3 = "$imagePath/restyle_demo_3.jpeg";

  final String animeDemo1 = "$imagePath/anime_demo_1.jpeg";
  final String animeDemo2 = "$imagePath/anime_demo_2.jpeg";
  final String animeDemo3 = "$imagePath/anime_demo_3.jpeg";

  /// Icons
  static const String iconPath = '$imagePath/icons';

  final String icEnhence = "$iconPath/ic_enhance.png";
  final String icArtEffect = "$iconPath/ic_art_effect.png";
  final String icRemoveObject = "$iconPath/ic_remove_object.png";
  final String icShare = "$iconPath/ic_share.png";
  final String icTerm = "$iconPath/ic_term.png";
  final String icFAQ = "$iconPath/ic_faq.png";
  final String icHand = "$iconPath/ic_hand.png";
  final String icRedo = "$iconPath/ic_redo.png";
  final String icUndo = "$iconPath/ic_undo.png";
  final String icCompare = "$iconPath/ic_compare.png";
  final String icEraser = "$iconPath/ic_eraser.png";
  final String icColor = "$iconPath/ic_color.png";
  final String icBrush = "$iconPath/ic_brush.png";
  final String icAI = "$iconPath/ic_ai.png";
  final String icImagePlaceholder = "$iconPath/ic_image_place_holder.png";
  final String icAnimeAI = "$iconPath/ic_anime_ai.png";
  final String icFeedback = "$iconPath/ic_feedback.png";
  final String icSeekbarThumb = "$iconPath/ic_seekbar_thumb.png";
}
