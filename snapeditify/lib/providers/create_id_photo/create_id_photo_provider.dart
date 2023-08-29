// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/create_id_photo/create_id_photo_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';

abstract class ICreateIDPhotoProvider extends EditImageProvider {
  @override
  CreateIDPhotoState get state;

  WidgetsToImageController get widgetsToImageController;

  Future<bool> removeBackground(BuildContext context);

  void changeBackgroundColor(Color color);

  void changeRatio(double ratio);
}

class CreateIDPhotoProvider extends ICreateIDPhotoProvider {
  static final ICreateIDPhotoProvider _instance = CreateIDPhotoProvider.internal();

  static ICreateIDPhotoProvider get instance => _instance;

  CreateIDPhotoProvider.internal() {
    _widgetsToImageController = WidgetsToImageController();
    _state = CreateIDPhotoState();
    _state.addListener(() {
      Debug.log("Hello==========>");
      notifyListeners();
    });
  }

  late CreateIDPhotoState _state;
  @override
  CreateIDPhotoState get state => _state;

  late WidgetsToImageController _widgetsToImageController;
  @override
  WidgetsToImageController get widgetsToImageController =>
      _widgetsToImageController;

  @override
  EditedImageVM get editedImage => throw UnimplementedError();

  @override
  bool get canSave => throw UnimplementedError();

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
    WidgetUtils.instance.showLoadingPopup();

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    RemoveBackgroundBody body = RemoveBackgroundBody(
        inputImage: _state.image.imageBytes, imageId: null);
    final SnapEditResponse<RemoveBackgroundResponse?> res =
        await Services.instance.snapEdit.removeBackground(body);
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
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = CreateIDPhotoState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }
}
