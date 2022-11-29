part of '../constants.dart';

///APP IMAGES
class AppImages {
  static final AppImages _instance = AppImages._internal();
  static AppImages get instance => _instance;

  factory AppImages() => _instance;

  AppImages._internal();

  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/images/icons';

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

  final String homeBanner = '$imagePath/home_banner.png';
  final String homeBefore = '$imagePath/home_before.jpeg';
  final String homeAfter = '$imagePath/home_after.jpeg';
  final String beforeAfter = '$imagePath/before_after.png';
  final String placeholder = '$imagePath/placeholder.png';
  final String logo = '$imagePath/logo.png';
}
