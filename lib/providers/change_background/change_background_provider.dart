// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/change_background/change_background_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/widgets_to_image.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IChangeBackgroundProvider extends EditImageProvider {
  @override
  ChangeBackgroundState get state;

  WidgetsToImageController get widgetsToImageController;

  Future<bool> removeBackground(BuildContext context);

  void changeBackgroundColor(Color color);

  void changeRatio(double ratio);
}

class ChangeBackgroundProvider extends IChangeBackgroundProvider {
  static final IChangeBackgroundProvider _instance = ChangeBackgroundProvider.internal();

  static IChangeBackgroundProvider get instance => _instance;

  ChangeBackgroundProvider.internal() {
    _widgetsToImageController = WidgetsToImageController();
    _state = ChangeBackgroundState();
    _state.addListener(notifyListeners);
  }

  late ChangeBackgroundState _state;
  @override
  ChangeBackgroundState get state => _state;

  late WidgetsToImageController _widgetsToImageController;
  @override
  WidgetsToImageController get widgetsToImageController => _widgetsToImageController;

  EditedImageVM? _editedImage;
  @override
  EditedImageVM? get editedImage => _editedImage;

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
  Future<bool> saveImage(BuildContext context) async {
    final Uint8List? imageBytes = await _widgetsToImageController.capture();
    if(imageBytes != null) {
      final imageUI = await ImageUtils.instance.toImageUI(imageBytes);
      _editedImage = EditedImageVM(imageBytes, imageUI);
    }
    return super.saveImage(context);
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
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = ChangeBackgroundState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }
}
