// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/anime_ai/anime_ai_state.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/storage_provider.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/services/snap_edit/src/models/body/anime_ai_image_body.dart';
import 'package:phosart/services/snap_edit/src/models/body/anime_ai_video_body.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_image_response.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_styles_response.dart';
import 'package:phosart/services/snap_edit/src/models/response/anime_video_response.dart';
import 'package:phosart/utils/widget.dart';
import 'package:phosart/view_models/edited_image_vm.dart';
import 'package:phosart/widgets/painter/painter.dart';

abstract class IAnimeAIProvider extends EditImageProvider with StorageProvider {
  List<AnimeStyle> get styles;

  List<String> get categories;

  String? get category;

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

  final List<AnimeStyle> _styles = [];
  @override
  List<AnimeStyle> get styles => _styles;

  final List<String> _categories = [];

  @override
  List<String> get categories => _categories;

  late AnimeAIState _state;
  @override
  AnimeAIState get state => _state;

  String? _category;
  @override
  String? get category => _category;
  set category(String? val) {
    if (_category != val) {
      _category = val;
      notifyListeners();
    }
  }

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
    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!.outputImages.first.image, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup(context);

    /// CALL API
    AnimeAIImageBody body = AnimeAIImageBody(style: styleId, inputImage: originalImage.imageBytes);
    SnapEditResponse<AnimeImageResponse?> res = await Services.instance.snapEdit.animeRestyle(body);

    Debug.log(res.data!.outputImages.first.imageId);

    if (res.data != null) {
      await _state.setImage(res.data!.outputImages.first.image, styleId: styleId);
      _state.styledImages[styleId] = res.data!;
      notifyListeners();

      /// HIDE LOADING POPUP
      Navigator.pop(context);
      return true;
    }

    /// HIDE LOADING POPUP
    Navigator.pop(context);

    if (res.error != null) {
      WidgetUtils.instance.alert(context, title: 'Restyle Image', message: res.error!.toString());
      Debug.log('====== RESTYLE IMAGE ${res.error} ======');
    }
    return false;
  }

  @override
  Future<bool> videoEffect(BuildContext context, String styleId) async {
    // if (_state.styledImages.containsKey(styleId)) {
    //   _state.setImage(_state.styledImages[styleId]!, styleId: styleId);
    //   notifyListeners();
    //   return true;
    // }

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup(context);

    /// CALL API
    AnimeAIVideoBody body = AnimeAIVideoBody(
      style: styleId,
      outputImageId: _state.styledImages[styleId]!.outputImages.first.imageId,
      imageId: _state.styledImages[styleId]!.imageId,
    );
    Debug.log(styleId);
    SnapEditResponse<AnimeVideoResponse?> res = await Services.instance.snapEdit.animeVideoEffect(body);

    if (res.data != null) {
      /// HIDE LOADING POPUP
      Navigator.pop(context);
      return true;
    }

    /// HIDE LOADING POPUP
    Navigator.pop(context);

    if (res.error != null) {
      WidgetUtils.instance.alert(context, title: 'Restyle Image', message: res.error!.toString());
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
  Future<void> syncFromServer([bool notify = false]) async {
    Locale locale = ManagerProvider.of<ThemeProvider>().currentLocale;
    SnapEditResponse<AnimeStylesResponse?> res = await Services.instance.snapEdit.getAnimeStyles(locale.languageCode);

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
      AnimeStylesResponse data = AnimeStylesResponse.fromJson(styleStrings);
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
    AsyncStorage.instance.remove(AppSharedKey.instance.animeStyles);
    return true;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = AnimeAIState();
    _state.addListener(notifyListeners);
    return true;
  }
}
