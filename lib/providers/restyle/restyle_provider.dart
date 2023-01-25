// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_state.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/services/snap_edit/src/models/response/styles_response.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/painter/painter.dart';

abstract class IRestyleProvider extends EditImageProvider with StorageProvider {
  List<Style> get styles;

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
    return _state.setImage(originalImage.imageBase64, styleId: null);
  }

  @override
  Future<bool> restyleImage(BuildContext context, String styleId) async {
    renewSavedFile();

    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup(context, message: 'Please wait a moment!');

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    RestyleBody body = RestyleBody(styleId: styleId, inputImage: originalImage.imageBytes, imageId: _state.imageId);
    SnapEditResponse<RestyleResponse?> res = await Services.instance.snapEdit.restyle(body);

    if (res.data != null) {
      await _state.setImage(res.data!.outputImage, styleId: styleId);
      _state.styledImages[styleId] = res.data!.outputImage;
      notifyListeners();

      /// HIDE LOADING POPUP
      Navigator.pop(context);
      return true;
    }

    /// HIDE LOADING POPUP
    Navigator.pop(context);

    if (res.error != null) {
      WidgetUtils.instance.alert(context, title: 'Restyle Image', message: res.error.toString());
      Debug.log('====== RESTYLE IMAGE ${res.error} ======');
    }

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
