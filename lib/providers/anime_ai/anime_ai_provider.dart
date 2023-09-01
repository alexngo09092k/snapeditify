// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/services/snap_edit/src/apis/generate_video.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IAnimeAIProvider extends EditImageProvider with StorageProvider {
  @override
  AnimeAIState get state;

  List<Effect> get styles;

  List<String> get categories;

  String? category;

  bool get canRevert;
  bool get canCompare;

  Future<bool> restyleImage(BuildContext context, String styleId);
  Future<bool> videoEffect(BuildContext context, String styleId);

  Future<bool> compare();
}

class AnimeAIProvider extends IAnimeAIProvider with ProviderDelegate {
  static final IAnimeAIProvider _instance = AnimeAIProvider.internal();

  static IAnimeAIProvider get instance => _instance;

  AnimeAIProvider.internal() {
    _state = AnimeAIState();
    _state.addListener(notifyListeners);
  }

  final List<Effect> _styles = [];
  @override
  List<Effect> get styles {
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

  late AnimeAIState _state;
  @override
  AnimeAIState get state => _state;

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
  Future<bool> restyleImage(BuildContext context, String styleId) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => restyleImage(context, styleId));
    if (!result) return false;

    renewSavedFile();
    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!.outputImages.first.image, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    LoadingPopup.show("Please wait amoment!");

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    AnimeBody body = AnimeBody(style: styleId, inputImage: originalImage.imageBytes);
    SnapEditResponse<AnimeResponse?> res = await Services.instance.snapEdit.animeImage(body);

    if (res.data != null) {
      await _state.setImage(res.data!.outputImages.first.image, styleId: styleId);
      _state.styledImages[styleId] = res.data!;
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
        message: S.of(context).failedToStyleImagePleaseTryAgain, 
        retry: (_) => restyleImage(context, styleId),
      );
      Debug.log('====== RESTYLE IMAGE ${res.message} ======');
    }
    return false;
  }

  @override
  Future<bool> videoEffect(BuildContext context, String styleId) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => videoEffect(context, styleId));
    if (!result) return false;

    /// SHOW LOADING POPUP
    LoadingPopup.show("Please wait amoment!");

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    GenerateVideoBody body = GenerateVideoBody(
      outputImageId: _state.styledImages[styleId]!.outputImages.first.imageId,
      imageId: _state.styledImages[styleId]!.imageId,
    );

    SnapEditResponse<GenerateVideoResponse?> res = await Services.instance.snapEdit.generateVideo(body);

    if (res.data != null) {
      /// HIDE LOADING POPUP
      WidgetUtils.instance.dimiss();
      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).restyleImage, 
        message: S.of(context).failedToStyleImagePleaseTryAgain, 
        retry: (_) => videoEffect(context, styleId),
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
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().locale;
    SnapEditResponse<RestyleEffectsResponse?> res = await Services.instance.snapEdit.getAnimeStyles(locale.languageCode);

    if (res.data != null) {
      Debug.log("===== SYNC FROM SERVER GET ANIME EFFECTS ${res.data} =====");
      AsyncStorage.instance.setString(AsyncStorageKey.instance.animeEffects, res.data!.toJson());
    }

    if (!res.status) {
      Debug.log("===== SYNC FROM SERVER GET ANIME EFFECTS ERROR ${res.message} =====");
    }

    syncFromStorage(notify);

    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    String? styleStrings = AsyncStorage.instance.getString(AsyncStorageKey.instance.animeEffects);
    if (styleStrings != null) {
      Debug.log("===== SYNC FROM STORAGE $styleStrings =====");
      RestyleEffectsResponse data = RestyleEffectsResponse.fromJson(styleStrings);
      _styles.clear();
      _styles.addAll(data.styles);
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
  void clean([bool notify = false]) {
    _styles.clear();
    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AsyncStorageKey.instance.animeEffects);
    return true;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = AnimeAIState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }
}
