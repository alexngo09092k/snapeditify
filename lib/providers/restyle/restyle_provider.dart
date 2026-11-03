// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_state.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';
import 'package:snapeditify/utils/ad_revenue_manager.dart';

abstract class IRestyleProvider extends EditImageProvider implements StorageProvider {
  @override
  RestyleState get state;
  
  List<Effect> get effects;

  bool get canRevert;
  bool get canCompare;

  Future<bool> restyleImage(BuildContext context, String styleId);

  Future<bool> revert(BuildContext context);

  Future<bool> compare(BuildContext context);
}

class RestyleProvider extends IRestyleProvider with ProviderDelegate {
  static final IRestyleProvider _instance = RestyleProvider.internal();

  static IRestyleProvider get instance => _instance;

  RestyleProvider.internal() {
    _state = RestyleState();
    _state.addListener(notifyListeners);
  }

  final List<Effect> _effects = [];
  @override
  List<Effect> get effects {
    if(_effects.isEmpty) syncFromServer(true);
    return  _effects;
  }

  late RestyleState _state;
  @override
  RestyleState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => _state.image.imageBase64 != originalImage.imageBase64;

  @override
  bool get canRevert => _state.image.imageBase64 != originalImage.imageBase64;

  @override
  bool get canCompare => _state.image.imageBase64 != originalImage.imageBase64;

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
  Future<bool> revert(BuildContext context) async {
    Debug.log("===== REVERT ====");
    return _state.setImage(originalImage.imageBytes, originalImage.imageBase64, styleId: null);
  }

  @override
  Future<bool> restyleImage(BuildContext context, String styleId) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => restyleImage(context, styleId));
    if (!result) return false;

    renewSavedFile();

    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!, originalImage.imageBase64, styleId: styleId);
      return true;
    }

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    bool ok = false;
    bool failed = false;
    String? failMessage;

    try {
      /// SHOW ADS
      AdRevenueManager.instance.onHighValueAction(placement: 'restyle');

      /// CALL API
      RestyleBody body = RestyleBody(styleId: styleId, inputImage: originalImage.imageBytes, imageId: _state.imageId);
      SnapEditResponse<RestyleImageResponse?> res = await Services.instance.snapEdit.restyle(body);

      if (res.data != null) {
        Uint8List imagebytes = base64.decode(res.data!.outputImage);
        _state.styledImages[styleId] = imagebytes;
        await _state.setImage(imagebytes, res.data!.outputImage,  styleId: styleId);
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
        title: S.of(context).restyle,
        message: S.of(context).unableToStyleImagePleaseTryAgain,
        retry: (_) => restyleImage(context, styleId),
      );
      Debug.log('====== RESTYLE IMAGE $failMessage ======');
    }

    return false;
  }

  @override
  Future<bool> registered() {
    syncFromServer(true);
    return super.registered();
  }

  @override
  void clean([bool notify = false]) {
    _effects.clear();
    _state.styledImages.clear();
    _state.setImage(originalImage.imageBytes, originalImage.imageBase64, styleId: null);
    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AsyncStorageKey.instance.restyleEffects);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().locale;
    SnapEditResponse<RestyleEffectsResponse?> res = await Services.instance.snapEdit.getRestyleEffects(locale.languageCode);

    if (res.data != null) {
      Debug.log("===== SYNC FROM SERVER GET RESTYLE EFFECTS ${res.data} =====");
      AsyncStorage.instance.setString(AsyncStorageKey.instance.restyleEffects, res.data!.toJson());
    }

    if (!res.status) {
      Debug.log("===== SYNC FROM SERVER GET RESTYLE EFFECTS ERROR ${res.message} =====");
    }

    syncFromStorage(notify);

    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    String? styleStrings = AsyncStorage.instance.getString(AsyncStorageKey.instance.restyleEffects);
    if (styleStrings != null) {
      Debug.log("===== SYNC FROM STORAGE $styleStrings =====");
      RestyleEffectsResponse data = RestyleEffectsResponse.fromJson(styleStrings);
      _effects.clear();
      _effects.addAll(data.styles);
    }
    if (notify) notifyListeners();
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = RestyleState();
    _state.addListener(notifyListeners);
    return true;
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    _state.dispose();
    super.dispose();
  }
}
