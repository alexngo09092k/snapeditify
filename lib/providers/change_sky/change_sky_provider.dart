// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/change_sky/change_sky_state.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IChangeSkyProvider extends EditImageProvider with StorageProvider {
  @override
  ChangeSkyState get state;
  
  List<Background> get styles;

  List<String> get categories;

  String? category;

  bool get canRevert;
  bool get canCompare;

  Future<bool> skyImage(BuildContext context, String styleId);

  Future<bool> revert(BuildContext context);

  Future<bool> compare(BuildContext context);
}

class ChangeSkyProvider extends IChangeSkyProvider with ProviderDelegate {
  static final IChangeSkyProvider _instance = ChangeSkyProvider.internal();

  static IChangeSkyProvider get instance => _instance;

  ChangeSkyProvider.internal() {
    _state = ChangeSkyState();
    _state.addListener(notifyListeners);
  }

  final List<Background> _styles = [];
  @override
  List<Background> get styles {
    if(_styles.isEmpty) syncFromServer(true);
    return  _styles;
  }

  final List<String> _categories = [];

  @override
  List<String> get categories {
    if(_categories.isEmpty) syncFromServer(true);
    return  _categories;
  }

  String? _category;
  @override
  String? get category => _category;
  @override
  set category(String? val) {
    if (_category != val) {
      _category = val;
      notifyListeners();
    }
  }

  late ChangeSkyState _state;
  @override
  ChangeSkyState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

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
    return _state.setImage(originalImage.imageBytes, styleId: null);
  }

  @override
  Future<bool> skyImage(BuildContext context, String styleId) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => skyImage(context, styleId));
    if (!result) return false;

    renewSavedFile();

    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    LoadingPopup.show("Please wait amoment!");

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    SkyMaskBody body = SkyMaskBody(styleId: styleId, inputImage: originalImage.imageBytes);
    SnapEditResponse<SkyMaskResponse?> res = await Services.instance.snapEdit.changeSky(body);

    if (res.data != null) {
      Uint8List imageBytes = base64.decode(res.data!.mask);
      await _state.setImage(imageBytes, styleId: styleId);
      _state.styledImages[styleId] = imageBytes;
      notifyListeners();

      /// HIDE LOADING POPUP
      LoadingPopup.hide();
      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).restyleImage, 
        message: S.of(context).failedToChangeStylePleaseTryAgain, 
        retry: (_) => skyImage(context, styleId),
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
    _state.setImage(originalImage.imageBytes, styleId: null);
    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AsyncStorageKey.instance.skyEffects);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().locale;
    SnapEditResponse<BackgroundResponse?> res = await Services.instance.snapEdit.getSkyEffects(locale.languageCode);

    if (res.data != null) {
      Debug.log("===== SYNC FROM SERVER GET SKY EFFECTS ${res.data} =====");
      AsyncStorage.instance.setString(AsyncStorageKey.instance.skyEffects, res.data!.toJson());
    }

    if (!res.status) {
      Debug.log("===== SYNC FROM SERVER GET SKY EFFECTS ERROR ${res.message} =====");
    }

    syncFromStorage(notify);

    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    String? styleStrings = AsyncStorage.instance.getString(AsyncStorageKey.instance.skyEffects);
    if (styleStrings != null) {
      Debug.log("===== SYNC FROM STORAGE $styleStrings =====");
      BackgroundResponse data = BackgroundResponse.fromJson(styleStrings);
      _styles.clear();
      _styles.addAll(data.backgrounds);
      for (var style in _styles) {
        if (!_categories.contains(style.category)) {
          _categories.add(style.category);
        }
      }
      _category = _categories.first;
    }
    if (notify) notifyListeners();
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = ChangeSkyState();
    _state.addListener(notifyListeners);
    return true;
  }
}
