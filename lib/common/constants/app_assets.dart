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
  final String icArrowRight = "$iconPath/ic_arrow_right.png";
  final String icStarNormal = "$iconPath/ic_star_normal.png";
  final String icStarHighlight = "$iconPath/ic_star_highlight.png";
  final String icClose = "$iconPath/ic_close.png";
  final String icArrowRating = "$iconPath/ic_arrow_rating.png";
  final String icBling = "$iconPath/ic_bling.png";
  final String icStar = "$iconPath/ic_star.png";

  final String icAddPhotoNormal3x = '$iconPath/ic_add_photo_Normal@3x.png';
  final String icArrowRightNormal3x = '$iconPath/ic_arrow_right_Normal@3x.png';
  final String icBackNormal3x = '$iconPath/ic_back_Normal@3x.png';
  final String icBirthdayNormal3x = '$iconPath/ic_birthday_Normal@3x.png';
  final String icBrushHighlightNormal3x = '$iconPath/ic_brush_highlight_Normal@3x.png';
  final String icBrushNormalNormal3x = '$iconPath/ic_brush_normal_Normal@3x.png';
  final String icCheckboxNormalNormal3x = '$iconPath/ic_checkbox_normal_Normal@3x.png';
  final String icCheckboxReloadNormal3x = '$iconPath/ic_checkbox_reload_Normal@3x.png';
  final String icCheckboxSelectedNormal3x = '$iconPath/ic_checkbox_selected_Normal@3x.png';
  final String icCheckmarkCircleNormal3x = '$iconPath/ic_checkmark_circle_Normal@3x.png';
  final String icCheckmarkNormal3x = '$iconPath/ic_checkmark_Normal@3x.png';
  final String icCompareNormal3x = '$iconPath/ic_compare_Normal@3x.png';
  final String icCrownNormal3x = '$iconPath/ic_crown_Normal@3x.png';
  final String icDeleteNormal3x = '$iconPath/ic_delete_Normal@3x.png';
  final String icEraserSelectedNormal3x = '$iconPath/ic_eraser_selected_Normal@3x.png';
  final String icEraserUnselectedNormal3x = '$iconPath/ic_eraser_unselected_Normal@3x.png';
  final String icFaceIdHighlightNormal3x = '$iconPath/ic_face_id_highlight_Normal@3x.png';
  final String icFaceIdNormalNormal3x = '$iconPath/ic_face_id_normal_Normal@3x.png';
  final String icFingerbrushSelectedNormal3x = '$iconPath/ic_finger_brush_selected_Normal@3x.png';
  final String icFingerbrushUnselectedNormal3x = '$iconPath/ic_finger_brush_unselected_Normal@3x.png';
  final String icGraLoadingNormal3x = '$iconPath/ic_gray_loading_Normal@3x.png';
  final String icGreenCheckmarkNormal3x = '$iconPath/ic_green_checkmark_Normal@3x.png';
  final String icGroupsNormal3x = '$iconPath/ic_groups_Normal@3x.png';
  final String icInfoNormal3x = '$iconPath/ic_info_Normal@3x.png';
  final String icLoadingNormal3x = '$iconPath/ic_loading_Normal@3x.png';
  final String icRedoDisabledNormal3x = '$iconPath/ic_redo_disabled_Normal@3x.png';
  final String icRedoNormalNormal3x = '$iconPath/ic_redo_normal_Normal@3x.png';
  final String icRevertNormal3x = '$iconPath/ic_revert_Normal@3x.png';
  final String icShareNormal3x = '$iconPath/ic_share_Normal@3x.png';
  final String icThumbSliderNormal3x = '$iconPath/ic_thumb_slider_Normal@3x.png';
  final String icUndoDisabledNormal3x = '$iconPath/ic_undo_disabled_Normal@3x.png';
  final String icUndoNormalNormal3x = '$iconPath/ic_undo_normal_Normal@3x.png';
  final String icWhiteXNormal3x = '$iconPath/ic_white_x_Normal@3x.png';
  final String imgDisconnectedNormal3x = '$iconPath/img_disconnected_Normal@3x.png';
  final String imgNoObjectsNormal3x = '$iconPath/img_no_objects_Normal@3x.png';
  final String imgOfflineNormal3x = '$iconPath/img_offline_Normal@3x.png';
  final String imgRequestPermissionNormal3x = '$iconPath/img_request_permission_Normal@3x.png';
  final String imgSplashCopyrightNormal3x = '$iconPath/img_splash_copyright_Normal@3x.png';

  final String homeBefore = '$imagePath/home_before.jpeg';
  final String homeAfter = '$imagePath/home_after.jpeg';
  final String beforeAfter = '$imagePath/before_after.png';
  final String placeholder = '$imagePath/placeholder.png';
  final String logo = '$imagePath/logo.png';
}
