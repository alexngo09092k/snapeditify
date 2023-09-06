// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/remove_bg/remove_bg_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IRemoveBGProvider extends EditImageProvider {
  @override
  RemoveBGState get state;

  Future<bool> removeBG(BuildContext context);
}

class RemoveBGProvider extends IRemoveBGProvider {
  static final IRemoveBGProvider _instance = RemoveBGProvider.internal();

  static IRemoveBGProvider get instance => _instance;

  RemoveBGProvider.internal() {
    _state = RemoveBGState();
    _state.addListener(notifyListeners);
  }

  late RemoveBGState _state;
  @override
  RemoveBGState get state => _state;

  @override
  EditedImageVM? get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => _state.mask.isNotEmpty;

  @override
  Future<bool> removeBG(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => removeBG(context));
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
        retry: (_) => removeBG(context),
      );
      Debug.log('===== REMOVE BACKGROUND IMAGE ${res.message} =====');
    }

    return false;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = RemoveBGState();
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
