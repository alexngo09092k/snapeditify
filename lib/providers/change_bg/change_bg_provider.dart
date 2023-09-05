// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/change_bg/change_bg_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/extensions/extensions.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IChangeBGProvider extends EditImageProvider with StorageProvider {
  @override
  ChangeBackgroundState get state;

  List<Background> get backgrounds;

  List<String> get categories;

  Future<bool> removeBG(BuildContext context);

  void changeBGColor(Color color);

  void changeBGImage(BuildContext context, Uint8List imageBytes);

  Future<bool> onRemovedBGImage(BuildContext context, Uint8List imageBytes);
}

class ChangeBGProvider extends IChangeBGProvider with ProviderDelegate {
  static final IChangeBGProvider _instance = ChangeBGProvider.internal();

  static IChangeBGProvider get instance => _instance;

  ChangeBGProvider.internal() {
    _state = ChangeBackgroundState();
    _state.addListener(notifyListeners);
  }

  final List<Background> _backgrounds = [];
  @override
  List<Background> get backgrounds => _backgrounds;

  final List<String> _categories = [];
  @override
  List<String> get categories => _categories;

  late ChangeBackgroundState _state;
  @override
  ChangeBackgroundState get state => _state;

  @override
  EditedImageVM? get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => _state.mask.isNotEmpty;

  @override
  void changeBGColor(Color color) {
    _state.bgColor = color;
  }

  @override
  void changeBGImage(BuildContext context, Uint8List imageBytes) async {
    ui.Image image = await ImageUtils.instance.toImageUI(imageBytes);
    ImageDrawable newDrawable = ImageDrawable(position: Offset.zero, image: image);
    _state.paint.replaceDrawable(_state.paint.drawables[0], newDrawable);
  }

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
  Future<bool> onRemovedBGImage(BuildContext context, Uint8List imageBytes) async {
   return setImage(context, bytes: imageBytes);
  }


  @override
  Future<bool> registered() {
    syncFromServer();
    return super.registered();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AsyncStorageKey.instance.backgroundEffects);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().locale;
    SnapEditResponse<BackgroundResponse?> res = await Services.instance.snapEdit.getBackgroundEffects(locale.languageCode);

    if (res.data != null) {
      Debug.log("===== SYNC FROM SERVER GET BACKGROUND EFFECTS ${res.data} =====");
      AsyncStorage.instance.setString(AsyncStorageKey.instance.backgroundEffects, res.data!.toJson());
    }

    if (!res.status) {
      Debug.log("===== SYNC FROM SERVER GET BACKGROUND EFFECTS ERROR ${res.message} =====");
    }

    syncFromStorage(notify);

    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    String? backgroundStrings = AsyncStorage.instance.getString(AsyncStorageKey.instance.backgroundEffects);
    if (backgroundStrings != null) {
      Debug.log("===== SYNC FROM STORAGE $backgroundStrings =====");
      BackgroundResponse data = BackgroundResponse.fromJson(backgroundStrings);
      _backgrounds.clear();
      _backgrounds.addAll(data.backgrounds);
      for (var background in _backgrounds) {
        if (!_categories.contains(background.category)) {
          _categories.add(background.category);
        }
      }
    }
    if (notify) notifyListeners();
  }

    
  @override
  void clean([bool notify = false]) {
    _backgrounds.clear();
    _state.setImage(originalImage.imageBytes, originalImage.imageBase64);
    if (notify) notifyListeners();
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = ChangeBackgroundState();
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
