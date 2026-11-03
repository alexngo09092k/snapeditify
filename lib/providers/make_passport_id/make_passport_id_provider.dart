// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/make_passport_id/make_passport_id_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';
import 'package:snapeditify/utils/ad_revenue_manager.dart';

abstract class IMakeIDPassportProvider extends EditImageProvider {
  @override
  MakePassportIDState get state;

  ScreenshotController get captureController;

  Future<bool> makePassportID(BuildContext context);

  void changeBackgroundColor(Color color);

  void changeRatio(double ratio);
}

class MakeIDPassportProvider extends IMakeIDPassportProvider {
  static final IMakeIDPassportProvider _instance = MakeIDPassportProvider.internal();

  static IMakeIDPassportProvider get instance => _instance;

  MakeIDPassportProvider.internal() {
    _captureController = ScreenshotController();
    _state = MakePassportIDState();
    _state.addListener(notifyListeners);
  }

  late MakePassportIDState _state;
  @override
  MakePassportIDState get state => _state;

  late ScreenshotController _captureController;
  @override
  ScreenshotController get captureController => _captureController;

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
  Future<bool> save(BuildContext context) async {
    final Uint8List? imageBytes = await _captureController.capture();
    if(imageBytes != null) {
      final imageUI = await ImageUtils.instance.toImageUI(imageBytes);
      _editedImage = EditedImageVM(imageBytes, imageUI);
    }
    return super.save(context);
  }

  @override
  Future<bool> makePassportID(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => makePassportID(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    bool ok = false;
    bool failed = false;
    String? failMessage;

    try {
      /// SHOW ADS
      AdRevenueManager.instance.onHighValueAction(placement: 'passport');

      /// CALL API
      MakePassportIDBody body = MakePassportIDBody(inputImage: _state.image.imageBytes, imageId: null);
      final SnapEditResponse<MakePassportIDResponse?> res = await Services.instance.snapEdit.makePassportID(body);
      if (res.data != null) {
        /// REMOVED BACKGROUND IMAGE
        _state.mask = base64.decode(res.data!.output);
        ok = true;
      } else if (!res.status) {
        failed = true;
        failMessage = res.message;
      }
    } finally {
      LoadingPopup.hide();
    }

    if (ok) return true;

    if (failed) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).createIdPhoto,
        message: S.of(context).unableToCreateIdPhotoPleaseTryAgain,
        retry: (_) => makePassportID(context),
      );
      Debug.log('===== REMOVE BACKGROUND IMAGE $failMessage =====');
    }

    return false;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = MakePassportIDState();
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
