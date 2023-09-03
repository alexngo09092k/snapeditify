// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_guide.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/restore/restore_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IRestoreProvider extends EditImageProvider {
  @override
  RestoreState get state;

  PainterController get paintBefore;

  Future<bool> restoreImage(BuildContext context);

  Future<bool> videoEffect(BuildContext context);

  bool showEnhanceGuide();
}

class RestoreProvider extends IRestoreProvider {
  static final IRestoreProvider _instance = RestoreProvider.internal();

  static IRestoreProvider get instance => _instance;

  RestoreProvider.internal() {
    _state = RestoreState();
    _state.addListener(notifyListeners);

    _paintBefore = PainterController();
    _paintBefore.addListener(notifyListeners);
  }

  late RestoreState _state;
  @override
  RestoreState get state => _state;

  late PainterController _paintBefore;
  @override
  PainterController get paintBefore => _paintBefore;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave =>  _state.image.imageBase64 != originalImage.imageBase64;

  @override
  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    final result = await super.setImage(context, bytes: bytes, refesh: refesh);
    if(result) {
      _paintBefore.background = originalImage.imageUI.backgroundDrawable;
    }
    return result;
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
      final imageBase64 = res.data!.outputImage.image;
      final imageBytes = base64.decode(res.data!.outputImage.image);
      await _state.setImage(
        imageBytes, 
        imageBase64, 
        imageId: res.data!.imageId, 
        outputImageId: res.data!.outputImage.imageId,
      );
      
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
        retry: (_) => restoreImage(context),
      );
      Debug.log('===== ENAHNCE IMAGE ${res.message} =====');
    }

    return false;
  }

   @override
  Future<bool> videoEffect(BuildContext context) async {

    if(_state.imageId == null || _state.outputImageId == null) return false;

    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => videoEffect(context));
    if (!result) return false;

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    GenerateVideoBody body = GenerateVideoBody(
      outputImageId: _state.outputImageId!,
      imageId: _state.imageId!,
    );

    SnapEditResponse<GenerateVideoResponse?> res = await Services.instance.snapEdit.generateVideo(body);

    if (res.data != null) {
      _state.videoURL = res.data!.outputVideoUrl;

      /// HIDE LOADING POPUP
      WidgetUtils.instance.dimiss();
      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).restyleImage, 
        message: S.of(context).failedToStyleImagePleaseTryAgain, 
        retry: (_) => videoEffect(context),
      );
      Debug.log('====== RESTYLE IMAGE ${res.message} ======');
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
    _state = RestoreState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }
}
