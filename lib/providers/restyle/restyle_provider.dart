// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/restyle/restyle_state.dart';
import 'package:snapedit/providers/storage_provider.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/services/snap_edit/src/models/response/styles_response.dart';

abstract class IRestyleProvider extends EditImageProvider with StorageProvider {
  Future<bool> restyleImage(String styleId);

  bool get isLoading;

  List<Style> get styles;

  @override
  RestyleState get state;
}

class RestyleProvider extends IRestyleProvider with ProviderDelegate {
  static final IRestyleProvider _instance = RestyleProvider.internal();

  static IRestyleProvider get instance => _instance;

  RestyleProvider.internal() {
    _state = RestyleState();
    _state.addListener(notifyListeners);
    _states[DEFAULT_IMAGE] = _state;
  }

  final List<Style> _styles = [];
  @override
  List<Style> get styles => _styles;

  bool _isLoading = true;
  @override
  bool get isLoading => _isLoading;

  late RestyleState _state;
  @override
  RestyleState get state => _state;

  final Map<String, RestyleState> _states = {};

  final String DEFAULT_IMAGE = 'DEFAULT_IMAGE';

  @override
  Future<bool> restyleImage(String styleId) async {
    if (_states.containsKey(styleId)) {
      _state = _states[styleId]!;
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP

    RestyleBody body = RestyleBody(styleId: styleId, inputImage: imageFile, imageId: _state.imageId);
    SnapEditResponse<RestyleResponse?> res = await Services.instance.snapEdit.restyle(body);

    if (res.data != null) {
      _state = _state.copyWith(imageId: res.data!.imageId);
      await _state.setImage(res.data!.outputImage, createImageFile: _state.imageId == null);
      _states[styleId] = _state;
      notifyListeners();

      /// HIDE LOADING POPUP
      return true;
    }

    if (res.error != null) {
      Debug.log('====== RESTYLE IMAGE ${res.error} ======');
    }

    /// HIDE LOADING POPUP
    return false;
  }

  @override
  Future<bool> registered() {
    syncFromServer();
    return super.registered();
  }

  @override
  void clean([bool notify = false]) {
    _isLoading = true;
    _states.clear();
    _styles.clear();
    _state = _states[DEFAULT_IMAGE]!;
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
  }
}
