part of '../constants.dart';

///APP IMAGES
class AppAssets {
  static final AppAssets _instance = AppAssets._internal();
  static AppAssets get instance => _instance;

  factory AppAssets() => _instance;

  AppAssets._internal();

  /// Lotties
  static const String lottiePath = 'assets/lotties';

  final String animRatingStar = '$lottiePath/anim_rating_star.json';
  final String auToAIAnim = '$lottiePath/autoai_anim.json';
  final String brushAnim = '$lottiePath/brush_anim.json';
  final String enhanceGuideBfAf = '$lottiePath/enhance_guide_bf_af.json';
  final String homeArtEffectBanner = '$lottiePath/home_art_effect_banner.json';
  final String homeEnhanceBanner = '$lottiePath/home_enhance_banner.json';
  final String homeRemoveObjectBanner = '$lottiePath/home_remove_object_banner.json';

  /// Images
  static const String imagePath = 'assets/images';

  final String bgProBanner = "$imagePath/bg_pro_banner.webp";
  final String bgShareImage = "$imagePath/bg_share_image.webp";
  final String snapEditDemo1 = "$imagePath/snapedit_demo_1.jpg";
  final String snapEditDemo2 = "$imagePath/snapedit_demo_2.jpeg";
  final String snapEditDemo3 = "$imagePath/snapedit_demo_3.jpg";
  final String snapEditEnhanceDemo1 = "$imagePath/snapedit_enhance_demo_1.jpeg";
  final String snapEditEnhanceDemo2 = "$imagePath/snapedit_enhance_demo_2.jpeg";
  final String snapEditEnhanceDemo3 = "$imagePath/snapedit_enhance_demo_3.jpeg";
  final String restyleDemo1 = "$imagePath/restyle_demo_1.jpeg";
  final String restyleDemo2 = "$imagePath/restyle_demo_2.jpeg";
  final String restyleDemo3 = "$imagePath/restyle_demo_3.jpeg";
  final String snapEditCopyRightTitle = "$imagePath/snapedit_copy_right_title.png";
  final String snapEditLogoFull = "$imagePath/snapedit_logo_full.png";
  final String snapEditLogoText = "$imagePath/snapedit_logo_text.png";
  final String splashTitle = "$imagePath/splash_title.png";
  final String noObject = "$imagePath/no_object.webp";

  /// Icons
  static const String iconPath = 'assets/images/icons';

  final String icProBanner = "$iconPath/ic_pro_banner.webp";
  final String icPro = "$iconPath/ic_pro.png";
  final String icProBadge = "$iconPath/ic_pro_badge.png";
  final String icMenu = "$iconPath/ic_menu.png";
  final String icEnhence = "$iconPath/ic_enhance.png";
  final String icArtEffect = "$iconPath/ic_art_effect.png";
  final String icRemoveObject = "$iconPath/ic_remove_object.png";
  final String icNewBadge = "$iconPath/ic_new_badge.png";
  final String icAdd = "$iconPath/ic_add.png";
  final String icRate = "$iconPath/ic_rate.png";
  final String icShare = "$iconPath/ic_share.png";
  final String icTerm = "$iconPath/ic_term.png";
  final String icFAQ = "$iconPath/ic_faq.png";
  final String icFeedback = "$iconPath/ic_feedback.png";
  final String icProText = "$iconPath/ic_pro_text.png";
  final String icBack = "$iconPath/ic_back.png";
  final String icArrowLeft = "$iconPath/ic_arrow_left.png";
  final String icArrowRight = "$iconPath/ic_arrow_right.png";
  final String icStarNormal = "$iconPath/ic_star_normal.png";
  final String icStarHighlight = "$iconPath/ic_star_highlight.png";
  final String icClose = "$iconPath/ic_close.png";
  final String icArrowRating = "$iconPath/ic_arrow_rating.png";
  final String icBling = "$iconPath/ic_bling.png";
  final String icStar = "$iconPath/ic_star.png";
  final String icExpandMore = "$iconPath/ic_expand_more.png";
  final String icHand = "$iconPath/ic_hand.png";
  final String icRedo = "$iconPath/ic_redo.png";
  final String icUndo = "$iconPath/ic_undo.png";
  final String icCompare = "$iconPath/ic_compare.png";
  final String icEraser = "$iconPath/ic_eraser.png";
  final String icColor = "$iconPath/ic_color.png";
  final String icBrush = "$iconPath/ic_brush.png";
  final String icAI = "$iconPath/ic_ai.png";

  final String icBrushHighLight = "$iconPath/ic_brush_hightlight";
  final String icCheckboxReload = "$iconPath/ic_checkbox_reload.png";
  final String icCheckboxSelected = "$iconPath/ic_checkbox_selected.png";
  final String icCheckbox = "$iconPath/ic_checkbox.png";
  final String icCheckmarkCirlce = "$iconPath/ic_checkmark_cirlce.png";
  final String icCheckmark = "$iconPath/ic_checkmark.png";
  final String icCrown = "$iconPath/ic_crown.png";
  final String icDelete = "$iconPath/ic_delete.png";

  final String icGrayLoading = "$iconPath/ic_gray_loading.png";
  final String icGreenCheckmark = "$iconPath/ic_green_checkmark.png";
  final String icGroups = "$iconPath/ic_groups.png";
  final String icInfo = "$iconPath/ic_info.png";
  final String icLoading = "$iconPath/ic_loading.png";
  final String icRevert = "$iconPath/ic_revert.png";
  final String icThumbSlider = "$iconPath/ic_thumb_slider.png";
  final String icWhiteX = "$iconPath/ic_white_x.png";
}
