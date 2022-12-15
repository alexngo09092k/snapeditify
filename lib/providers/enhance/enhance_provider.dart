import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/models/enhance_handler.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/enhance/enhance_state.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/widgets/painter/painter.dart';

abstract class IEnhanceProvider extends EditImageProvider {
  Future<bool> enhanceImage();

  bool onChangeResult(String imageBase64);

  bool onChangeFace(String faceId);
}

class EnhanceProvider extends IEnhanceProvider {
  static final IEnhanceProvider _instance = EnhanceProvider.internal();

  static IEnhanceProvider get instance => _instance;

  EnhanceProvider.internal() {
    _state = EnhanceState();
    _state.addListener(notifyListeners);
  }

  late EnhanceState _state;
  @override
  EnhanceState get state => _state;

  @override
  Future<bool> setImage(BuildContext context, {required File file, bool refesh = true}) async {
    bool result = await super.setImage(context, file: file, refesh: refesh);
    if (result) enhanceImage();
    return result;
  }

  @override
  bool onChangeFace(String faceId) {
    if (_state.faces[faceId] != null) {
      FaceHandler face = _state.faces[faceId]!;
      _state.paintBefore.background = face.image!.backgroundDrawable;
      // _state.paintAfter.background = face.enhancedImageList[]
    }
    return false;
  }

  @override
  bool onChangeResult(String imageBase64) {
    if (_state.enhancedImageUIList[imageBase64] != null) {
      _state.paintAfter.background = _state.enhancedImageUIList[imageBase64]!.backgroundDrawable;
      return true;
    }
    return false;
  }

  @override
  Future<bool> enhanceImage() async {
    /// SHOW LOADING POPUP
    SmartDialog.showLoading();

    /// CALL API
    EnhanceBody body = EnhanceBody(inputImage: _state.imageFile, imageId: _state.imageId);
    final SnapEditResponse<EnhanceResponse?> res = await Services.instance.snapEdit.enhance(body);
    if (res.data != null) {
      /// HIDE LOADING POPUP
      SmartDialog.dismiss();
      _state.setImage(imageBase64, enhancedImageBase64List: res.data!.outputImages, provider: this);
      return true;
    }
    if (res.error != null) {
      SmartDialog.showToast(res.error!);
      Debug.log('===== ENAHNCE IMAGE ${res.error} =====');
    }

    /// HIDE LOADING POPUP
    SmartDialog.dismiss();
    return false;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = EnhanceState();
    _state.addListener(notifyListeners);
    return true;
  }

  @override
  Future<bool> saveImage(BuildContext context) {
    return checkoutSaveImage(context, () async {
      /// SAVE IMAGE
      return true;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
    });
  }
}
