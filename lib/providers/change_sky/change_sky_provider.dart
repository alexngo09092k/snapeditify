// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/change_sky/change_sky_state.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IChangeSkyProvider extends EditImageProvider with StorageProvider {
  @override
  ChangeSkyState get state;

  ScreenshotController get captureController;
  
  List<Background> get effects;

  List<String> get categories;

  String? category;

  Future<bool> removeSky(BuildContext context);

  Future<bool> changeSky(BuildContext context, Background effect);

}

class ChangeSkyProvider extends IChangeSkyProvider with ProviderDelegate {
  static final IChangeSkyProvider _instance = ChangeSkyProvider.internal();

  static IChangeSkyProvider get instance => _instance;

  ChangeSkyProvider.internal() {
    _captureController = ScreenshotController();

    _state = ChangeSkyState();
    _state.addListener(notifyListeners);
  }

  final List<Background> _effects = [];
  @override
  List<Background> get effects {
    if(_effects.isEmpty) syncFromServer(true);
    return  _effects;
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

  EditedImageVM? _editedImage;
  @override
  EditedImageVM? get editedImage => _editedImage;

  @override
  bool get canSave => _state.sky != null;

  late ScreenshotController _captureController;
  @override
  ScreenshotController get captureController => _captureController;


  @override
  Future<bool> removeSky(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => removeSky(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    SkyMaskBody body = SkyMaskBody(inputImage: originalImage.imageBytes);
    SnapEditResponse<SkyMaskResponse?> res = await Services.instance.snapEdit.removeSky(body);

    if (res.data != null) {
      /// REMOVED SKY IMAGE
      _state.mask = base64.decode(res.data!.mask);

      /// HIDE LOADING POPUP
      LoadingPopup.hide();
      return true;
    }

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).changeSky, 
        message: S.of(context).unableToChangeTheSkyOfTheImagePleaseTryAgain, 
        retry: (_) =>removeSky(context),
      );
      Debug.log('====== RESTYLE IMAGE ${res.message} ======');
    }

    return false;
  }

  @override
  Future<bool> changeSky(BuildContext context, Background effect) async {
    if (_state.styledImages.containsKey(effect.url)) {
      _state.paint.background = _state.styledImages[effect.url]!.backgroundDrawable;
      return true;
    }

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// SHOW ADS
    adProvider.handleAd();

    /// DOWNLOAD
    final String name = '${Configuration.instance.business.appName}_${DateTime.now().millisecond}';
    final Directory cacheDirectory = await getTemporaryDirectory();
    final String savePath = "${cacheDirectory.path}/$name.jpg";
    await Dio().downloadUri(
      Uri.parse(effect.url),
      savePath,
      onReceiveProgress: (received, total) async {
        if(received == total) {
          _state.sky = effect;
          Uint8List imageBytes = File(savePath).readAsBytesSync();
          ui.Image image = await ImageUtils.instance.toImageUI(imageBytes);
          _state.styledImages[effect.url] = image;
          _state.paint.background = image.backgroundDrawable;
          // late ImageDrawable newDrawable;
          // newDrawable = ImageDrawable(position: Offset.zero, image: image);
          // _state.paint.replaceDrawable(_state.paint.drawables[0], newDrawable);
        }
    });

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    return true;
  }

  @override
  Future<bool> save(BuildContext context) async {
    Uint8List? imageBytes = await _captureController.capture();
    if(imageBytes != null) {
      ui.Image imageUI = await ImageUtils.instance.toImageUI(imageBytes);
      _editedImage = EditedImageVM(imageBytes, imageUI);
      return super.save(context);
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
    _state.setImage(originalImage.imageBytes, originalImage.imageBase64);
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
      _effects.clear();
      _effects.addAll(data.backgrounds);
      for (var style in _effects) {
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
