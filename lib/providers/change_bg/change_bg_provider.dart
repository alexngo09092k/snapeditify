// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/change_bg/change_bg_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IChangeBGProvider extends EditImageProvider {
  @override
  ChangeBackgroundState get state;

  Future<bool> removeBackground(BuildContext context);

  void changeBackgroundColor(Color color);

  void changeRatio(double ratio);

  void onRemovedBGImage(Uint8List imageBytes);
}

class ChangeBGProvider extends IChangeBGProvider {
  static final IChangeBGProvider _instance = ChangeBGProvider.internal();

  static IChangeBGProvider get instance => _instance;

  ChangeBGProvider.internal() {
    _state = ChangeBackgroundState();
    _state.addListener(notifyListeners);
  }

  late ChangeBackgroundState _state;
  @override
  ChangeBackgroundState get state => _state;

  @override
  EditedImageVM? get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => _state.mask.isNotEmpty;

  @override
  void changeRatio(double ratio) {
    _state.ratio = ratio;
  }

  @override
  void changeBackgroundColor(Color color) {
    _state.color = color;
  }

  @override
  Future<bool> removeBackground(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => removeBackground(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    RemoveBackgroundBody body = RemoveBackgroundBody(inputImage: _state.image.imageBytes, imageId: null);
    final SnapEditResponse<RemoveBackgroundResponse?> res = await Services.instance.snapEdit.removeBackground(body);
    if (res.data != null) {
      /// REMOVED BACKGROUND IMAGE
      _state.mask = base64.decode(res.data!.output);

      /// HIDE LOADING POPUP
      WidgetUtils.instance.dimiss();

      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).createIdPhoto,
        message: "",
        retry: (_) => removeBackground(context),
      );
      Debug.log('===== REMOVE BACKGROUND IMAGE ${res.message} =====');
    }

    return false;
  }

  @override
  void onRemovedBGImage(Uint8List imageBytes) {
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = ChangeBackgroundState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    _state.dispose();
    super.dispose();
  }
}
