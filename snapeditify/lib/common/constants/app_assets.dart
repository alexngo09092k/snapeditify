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
  final String animePlaceholder = "$imagePath/anime.png";

  /// Flags
  static const String flagPath = '$imagePath/flags';

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
  final String icAnimeAI = "$iconPath/ic_anime_ai.png";
  final String icFeedback = "$iconPath/ic_feedback.png";
  final String icSeekbarThumb = "$iconPath/ic_seekbar_thumb.png";
  final String icPremium = "$iconPath/ic_premium.png";

  /// Tools
  final String oneTouchRemoveAll = "$imagePath/tools/1TouchRemoveAll.png";
  final String applyEffect = "$imagePath/tools/ApplyEffect.png";
  final String changeBackground = "$imagePath/tools/ChangeBackground.png";
  final String changeYourSky = "$imagePath/tools/ChangeYourSky.png";
  final String generateAnimeAI = "$imagePath/tools/CreateAnimeAI.png";
  final String enhanceImage = "$imagePath/tools/EnhancePortrait.png";
  final String makeIDPassport = "$imagePath/tools/MakeIDPassport.png";
  final String productPhoto = "$imagePath/tools/ProductPhoto.png";
  final String removeObject = "$imagePath/tools/RemoveObject.png";
  final String restorePhoto = "$imagePath/tools/RestorePhoto.png";
  final String upscaleImage = "$imagePath/tools/UpscaleImage.png";

  /// Suggest images demo
  /// Remove objects
  final String removeObject1 = "$imagePath/suggest_demos/remove_object1.webp";
  final String removeObject2 = "$imagePath/suggest_demos/remove_object2.webp";
  final String removeObject3 = "$imagePath/suggest_demos/remove_object3.webp";

  /// Enhance photos
  final String enhance1 = "$imagePath/suggest_demos/enhance1.webp";
  final String enhance2 = "$imagePath/suggest_demos/enhance2.webp";
  final String enhance3 = "$imagePath/suggest_demos/enhance3.webp";

  /// Passport Maker
  final String passportMaker1 = "$imagePath/suggest_demos/passport_maker1.webp";
  final String passportMaker2 = "$imagePath/suggest_demos/passport_maker2.webp";
  final String passportMaker3 = "$imagePath/suggest_demos/passport_maker3.webp";

  /// Restore
  final String restore1 = "$imagePath/suggest_demos/restore1.webp";
  final String restore2 = "$imagePath/suggest_demos/restore2.webp";
  final String restore3 = "$imagePath/suggest_demos/restore3.webp";

  /// Sky
  final String sky1 = "$imagePath/suggest_demos/sky1.webp";
  final String sky2 = "$imagePath/suggest_demos/sky2.webp";
  final String sky3 = "$imagePath/suggest_demos/sky3.webp";

  /// Anime AI
  final String anime1 = "$imagePath/suggest_demos/anime1.jpg";
  final String anime2 = "$imagePath/suggest_demos/anime2.webp";
  final String anime3 = "$imagePath/suggest_demos/anime3.jpg";

  /// Restyle
  final String restyle1 = "$imagePath/suggest_demos/restyle1.webp";
  final String restyle2 = "$imagePath/suggest_demos/restyle2.jpeg";
  final String restyle3 = "$imagePath/suggest_demos/restyle3.webp";

  /// Remove Background
  final String removeBG1 = "$imagePath/suggest_demos/remove_bg1.webp";
  final String removeBG2 = "$imagePath/suggest_demos/remove_bg2.webp";
  final String removeBG3 = "$imagePath/suggest_demos/remove_bg3.webp";
}
