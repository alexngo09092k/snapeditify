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
  final String confetti = "$lottiePath/confetti.json";

  /// Images
  static const String imagePath = 'assets/images';

  final String logo = "$imagePath/logo.png";
  final String placeholder = "$imagePath/placeholder.png";
  final String animePlaceholder = "$imagePath/anime.png";
  final String bgTransparent = "$imagePath/bg-transparent.png";
  final String noImage = "$imagePath/no_image.png";

  final String bgShareImage = "$imagePath/bg_share_image.png";
  final String notFoundObject = "$imagePath/not_found_object.png";
  final String notFoundImage = "$imagePath/not_found_image.png";

  /// Flags
  static const String flagPath = '$imagePath/flags';

  /// Icons
  static const String iconPath = '$imagePath/icons';

  final String icEnhance = "$iconPath/ic_enhance.png";
  final String icArtEffect = "$iconPath/ic_art_effect.png";
  final String icRemoveObject = "$iconPath/ic_remove_object.png";
  final String icRemoveBG = "$iconPath/ic_remove_bg.png";
  final String icRestoration = "$iconPath/ic_restoration.png";
  final String icOneTouch = "$iconPath/ic_one_touch.png";
  final String icEditor = "$iconPath/ic_editor.png";
  final String icSky = "$iconPath/ic_sky.png";
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
  final String removeObject1 = "$imagePath/suggest_demos/remove_object1.png";
  final String removeObject2 = "$imagePath/suggest_demos/remove_object2.png";
  final String removeObject3 = "$imagePath/suggest_demos/remove_object3.png";

  /// Enhance photos
  final String enhance1 = "$imagePath/suggest_demos/enhance1.png";
  final String enhance2 = "$imagePath/suggest_demos/enhance2.png";
  final String enhance3 = "$imagePath/suggest_demos/enhance3.png";

  /// Passport Maker
  final String passportMaker1 = "$imagePath/suggest_demos/passport_maker1.png";
  final String passportMaker2 = "$imagePath/suggest_demos/passport_maker2.png";
  final String passportMaker3 = "$imagePath/suggest_demos/passport_maker3.png";

  /// Restore
  final String restore1 = "$imagePath/suggest_demos/restore1.png";
  final String restore2 = "$imagePath/suggest_demos/restore2.png";
  final String restore3 = "$imagePath/suggest_demos/restore3.png";

  /// Sky
  final String sky1 = "$imagePath/suggest_demos/sky1.png";
  final String sky2 = "$imagePath/suggest_demos/sky2.png";
  final String sky3 = "$imagePath/suggest_demos/sky3.png";

  /// Anime AI
  final String anime1 = "$imagePath/suggest_demos/anime1.jpg";
  final String anime2 = "$imagePath/suggest_demos/anime2.png";
  final String anime3 = "$imagePath/suggest_demos/anime3.jpg";

  /// Restyle
  final String restyle1 = "$imagePath/suggest_demos/restyle1.png";
  final String restyle2 = "$imagePath/suggest_demos/restyle2.jpeg";
  final String restyle3 = "$imagePath/suggest_demos/restyle3.png";

  /// Remove Background
  final String removeBG1 = "$imagePath/suggest_demos/remove_bg1.png";
  final String removeBG2 = "$imagePath/suggest_demos/remove_bg2.png";
  final String removeBG3 = "$imagePath/suggest_demos/remove_bg3.png";
}
