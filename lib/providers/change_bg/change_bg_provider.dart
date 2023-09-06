// ignore_for_file: use_build_context_synchronously
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/change_bg/change_bg_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/extensions/extensions.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

abstract class IChangeBGProvider extends EditImageProvider with StorageProvider {
  @override
  ChangeBGState get state;

  List<Background> get effects;

  List<String> get categories;

  void changeBGColor(Color color);

  void changeBGImage(BuildContext context, Uint8List imageBytes);
}

class ChangeBGProvider extends IChangeBGProvider with ProviderDelegate {
  static final IChangeBGProvider _instance = ChangeBGProvider.internal();

  static IChangeBGProvider get instance => _instance;

  ChangeBGProvider.internal() {
    _state = ChangeBGState();
    _state.addListener(notifyListeners);
  }

  final List<Background> _effects = [];
  @override
  List<Background> get effects => _effects;

  final List<String> _categories = [];
  @override
  List<String> get categories => _categories;

  late ChangeBGState _state;
  @override
  ChangeBGState get state => _state;

  @override
  EditedImageVM? get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave => _state.mask.isNotEmpty;

  @override
  void changeBGColor(Color color) {
    _state.bgColor = color;
  }

  @override
  void changeBGImage(BuildContext context, Uint8List imageBytes, {Size? size}) async {
    ui.Image image = await ImageUtils.instance.toImageUI(imageBytes);
    late ImageDrawable newDrawable ;
    if(size != null) {
      newDrawable = ImageDrawable.fittedToSize(position: Offset.zero, image: image, size: size);
    } else {
      newDrawable = ImageDrawable(position: Offset.zero, image: image);
    }
    _state.paint.replaceDrawable(_state.paint.drawables[0], newDrawable);
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
    String? effectStrings = AsyncStorage.instance.getString(AsyncStorageKey.instance.backgroundEffects);
    if (effectStrings != null) {
      Debug.log("===== SYNC FROM STORAGE $effectStrings =====");
      BackgroundResponse data = BackgroundResponse.fromJson(effectStrings);
      _effects.clear();
      _effects.addAll(data.backgrounds);
      for (var effect in _effects) {
        if (!_categories.contains(effect.category)) {
          _categories.add(effect.category);
        }
      }
    }
    if (notify) notifyListeners();
  }

    
  @override
  void clean([bool notify = false]) {
    _effects.clear();
    _state.setImage(originalImage.imageBytes, originalImage.imageBase64);
    if (notify) notifyListeners();
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = ChangeBGState();
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
