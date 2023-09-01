// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_state.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/services/snap_edit/src/models/response/styles_response.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/painter/painter.dart';

abstract class IRestyleProvider extends EditImageProvider with StorageProvider {
  @override
  RestyleState get state;
  
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
  List<Style> get styles {
    if(_styles.isEmpty) syncFromServer(true);
    return  _styles;
  }

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
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => restyleImage(context, styleId));
    if (!result) return false;

    renewSavedFile();

    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup();

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
      WidgetUtils.instance.dimiss();
      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).restyleImage, 
        message: S.of(context).failedToChangeStylePleaseTryAgain, 
        retry: (_) => restyleImage(context, styleId),
      );
      Debug.log('====== RESTYLE IMAGE ${res.message} ======');
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
    AsyncStorage.instance.remove(AsyncStorageKey.instance.styles);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().locale;
    SnapEditResponse<StylesResponse?> res = await Services.instance.snapEdit.getStyles(locale.languageCode);

    if (res.data != null) {
      Debug.log("===== SYNC FROM SERVER GET STYLES ${res.data} =====");
      AsyncStorage.instance.setString(AsyncStorageKey.instance.styles, res.data!.toJson());
    }

    if (!res.status) {
      Debug.log("===== SYNC FROM SERVER GET STYLES ERROR ${res.message} =====");
    }

    syncFromStorage(notify);

    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    String? styleStrings = AsyncStorage.instance.getString(AsyncStorageKey.instance.styles);
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
