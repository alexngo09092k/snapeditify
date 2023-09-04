// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_guide.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/controllers/drawables/drawables.dart';
import 'package:snapeditify/widgets/app_use/painter/controllers/painter_controller.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IEnhanceProvider extends EditImageProvider {
  @override
  EnhanceState get state;

  PainterController get paintBefore;

  Future<bool> enhanceImage(BuildContext context);

  bool showEnhanceGuide();
}

class EnhanceProvider extends IEnhanceProvider {
  static final IEnhanceProvider _instance = EnhanceProvider.internal();

  static IEnhanceProvider get instance => _instance;

  EnhanceProvider.internal() {
    _state = EnhanceState();
    _state.addListener(notifyListeners);

    _paintBefore = PainterController();
    _paintBefore.addListener(notifyListeners);
  }

  late EnhanceState _state;
  @override
  EnhanceState get state => _state;

  late PainterController _paintBefore;
  @override
  PainterController get paintBefore => _paintBefore;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => _state.image.imageBase64 != originalImage.imageBase64;


  @override
  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    final result = await super.setImage(context, bytes: bytes, refesh: refesh);
    if(result) {
      _paintBefore.background = originalImage.imageUI.backgroundDrawable;
    }
    return result;
  }

  @override
  Future<bool> enhanceImage(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => enhanceImage(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    EnhanceBody body = EnhanceBody(inputImage: _state.image.imageBytes, imageId: _state.imageId);
    final SnapEditResponse<EnhanceImageResponse?> res = await Services.instance.snapEdit.enhanceImage(body);
    if (res.data != null && res.data!.outputImages.isNotEmpty) {
      final imageBase64 = res.data!.outputImages.first;
      final imageBytes = base64.decode(res.data!.outputImages.first);
      await _state.setImage(imageBytes, imageBase64);

      /// HIDE LOADING POPUP
      LoadingPopup.hide();

      /// SHOW GUIDE
      showEnhanceGuide();

      return true;
    }

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).enhanceImage, 
        message: S.of(context).failedToEnhanceImagePleaseTryAgain, 
        retry: (_) => enhanceImage(context),
      );
      Debug.log('===== ENAHNCE IMAGE ${res.message} =====');
    }

    return false;
  }

  @override
  bool showEnhanceGuide() {
    int? num = AsyncStorage.instance.getInt(AsyncStorageKey.instance.enhanceGuide);
    if (num != null && num > 1) return false;

    WidgetUtils.instance.showDialog(builder: (_) => const EnhanceGuide());
    AsyncStorage.instance.setInt(AsyncStorageKey.instance.autoAIGuide, num == null ? 1 : num + 1);
    return true;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = EnhanceState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _paintBefore.removeListener(notifyListeners);
    _paintBefore.dispose();
    super.dispose();
  }
}
