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
  final String createAnimeAI = "$imagePath/tools/CreateAnimeAI.png";
  final String enhanceImage = "$imagePath/tools/EnhancePortrait.png";
  final String makeIDPassport = "$imagePath/tools/MakeIDPassport.png";
  final String productPhoto = "$imagePath/tools/ProductPhoto.png";
  final String removeObject = "$imagePath/tools/RemoveObject.png";
  final String restorePhoto = "$imagePath/tools/RestorePhoto.png";
  final String upscaleImage = "$imagePath/tools/UpscaleImage.png";

  /// Suggest images demo
  /// Remove objects
  final String rmb1 = "$imagePath/suggest_demos/rmb1.jpeg";
  final String rmb2 = "$imagePath/suggest_demos/rmb2.jpeg";
  final String rmb3 = "$imagePath/suggest_demos/rmb3.jpeg";

  final String rmots1 = "$imagePath/suggest_demos/rmots1.jpeg";
  final String rmots2 = "$imagePath/suggest_demos/rmots2.jpg";
  final String rmots3 = "$imagePath/suggest_demos/rmots3.jpg";

  /// Enhance photos
  final String e1 = "$imagePath/suggest_demos/e1.jpeg";
  final String e2 = "$imagePath/suggest_demos/e2.jpg";
  final String e3 = "$imagePath/suggest_demos/e3.jpg";

  final String rs1 = "$imagePath/suggest_demos/rs1.jpg";
  final String rs2 = "$imagePath/suggest_demos/rs2.jpeg";
  final String rs3 = "$imagePath/suggest_demos/rs3.jpeg";

  /// Cutout objects
  final String rmbg1 = "$imagePath/suggest_demos/rmbg1.jpeg";
  final String rmbg2 = "$imagePath/suggest_demos/rmbg2.jpeg";
  final String rmbg3= "$imagePath/suggest_demos/rmbg3.jpeg";


  /// Apply effects
  final String csk1 = "$imagePath/suggest_demos/csk1.png";
  final String csk2 = "$imagePath/suggest_demos/csk2.png";
  final String csk3 = "$imagePath/suggest_demos/csk3.png";
}
