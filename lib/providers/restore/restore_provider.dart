// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/restore/restore_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/services/snap_edit/src/apis/restore.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IRestoreProvider extends EditImageProvider {
  @override
  RestoreState get state;

  bool get canCompare;

  Future<bool> restoreImage(BuildContext context);

  Future<bool> compare(BuildContext context);
}

class RestoreProvider extends IRestoreProvider {
  static final IRestoreProvider _instance = RestoreProvider.internal();

  static IRestoreProvider get instance => _instance;

  RestoreProvider.internal() {
    _state = RestoreState();
    _state.addListener(notifyListeners);
  }

  late RestoreState _state;
  @override
  RestoreState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => true;

  @override
  bool get canCompare => true;

  bool _compared = false;
  @override
  Future<bool> compare(BuildContext context) async {
    if (canCompare) {
      Debug.log("===== COMPARE ====");
      if (!_compared) {
        Debug.log("===== COMPARE ORIGINAL BACKGROUND====");
        _state.paint.background = originalImage.imageUI.backgroundDrawable;
        _compared = true;
      } else {
        Debug.log("===== COMPARE CURRENT BACKGROUND====");
        _state.paint.background = _state.image.imageUI.backgroundDrawable;
        _compared = false;
      }
      return true;
    }
    return false;
  }

  @override
  Future<bool> restoreImage(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => restoreImage(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    RestoreBody body = RestoreBody(inputImage: _state.image.imageBytes, imageId: _state.imageId);
    final SnapEditResponse<RestorationResponse?> res = await Services.instance.snapEdit.restoreImage(body);
    if (res.data != null) {
      await _state.setImage(base64.decode(res.data!.outputImage.image), provider: this, styleId: res.data!.outputImage.imageId);
      notifyListeners();
      
      /// HIDE LOADING POPUP
      LoadingPopup.hide();
      return true;
    }

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).enhanceImage, 
        message: S.of(context).failedToEnhanceImagePleaseTryAgain, 
        retry: (_) => restoreImage(context),
      );
      Debug.log('===== ENAHNCE IMAGE ${res.message} =====');
    }

    return false;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = RestoreState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }
}
