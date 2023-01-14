// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/restyle/restyle_state.dart';
import 'package:phosart/providers/storage_provider.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/services/snap_edit/src/models/response/styles_response.dart';
import 'package:phosart/view_models/edited_image_vm.dart';
import 'package:phosart/widgets/painter/painter.dart';

abstract class IRestyleProvider extends EditImageProvider with StorageProvider {
  List<Style> get styles;

  bool get canRevert;
  bool get canCompare;

  Future<bool> restyleImage(String styleId);

  Future<bool> revert();

  Future<bool> compare();
}

class RestyleProvider extends IRestyleProvider with ProviderDelegate {
  static final IRestyleProvider _instance = RestyleProvider.internal();

  static IRestyleProvider get instance => _instance;

  RestyleProvider.internal() {
    _state = RestyleState();
    _state.addListener(notifyListeners);
  }

  final List<Style> _styles = [];
  @override
  List<Style> get styles => _styles;

  late RestyleState _state;
  @override
  RestyleState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBase64, _state.image.imageUI);

  @override
  bool get canSave => _state.styledImages.isNotEmpty;

  @override
  bool get canRevert => _state.styledImages.isNotEmpty;

  @override
  bool get canCompare => _state.styledImages.isNotEmpty;

  bool _compared = false;
  @override
  Future<bool> compare() async {
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
  Future<bool> revert() async {
    Debug.log("===== REVERT ====");
    return _state.setImage(originalImage.imageBase64, styleId: null);
  }

  @override
  Future<bool> restyleImage(String styleId) async {
    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    SmartDialog.showLoading();

    /// CALL API
    RestyleBody body = RestyleBody(styleId: styleId, inputImage: originalImage.imageBytes, imageId: _state.imageId);
    SnapEditResponse<RestyleResponse?> res = await Services.instance.snapEdit.restyle(body);

    if (res.data != null) {
      await _state.setImage(res.data!.outputImage, styleId: styleId);
      _state.styledImages[styleId] = res.data!.outputImage;
      notifyListeners();

      /// HIDE LOADING POPUP
      SmartDialog.dismiss();
      return true;
    }

    if (res.error != null) {
      SmartDialog.showToast(res.error!);
      Debug.log('====== RESTYLE IMAGE ${res.error} ======');
    }

    /// HIDE LOADING POPUP
    SmartDialog.dismiss();
    return false;
  }

  @override
  Future<bool> registered() {
    syncFromServer();
    return super.registered();
  }

  @override
  void clean([bool notify = false]) {
    _styles.clear();
    _state.styledImages.clear();
    _state.setImage(originalImage.imageBase64, styleId: null);
    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AppSharedKey.instance.styles);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().currentLocale;
    SnapEditResponse<StylesResponse?> res = await Services.instance.snapEdit.getStyles(locale.languageCode);

    if (res.data != null) {
      Debug.log("===== SYNC FROM SERVER GET STYLES ${res.data} =====");
      AsyncStorage.instance.setString(AppSharedKey.instance.styles, res.data!.toJson());
    }

    if (res.error != null) {
      Debug.log("===== SYNC FROM SERVER GET STYLES ERROR ${res.error} =====");
    }

    syncFromStorage(notify);

    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    String? styleStrings = AsyncStorage.instance.getString(AppSharedKey.instance.styles);
    if (styleStrings != null) {
      Debug.log("===== SYNC FROM STORAGE $styleStrings =====");
      StylesResponse data = StylesResponse.fromJson(styleStrings);
      _styles.clear();
      _styles.addAll(data.styles);
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
}
