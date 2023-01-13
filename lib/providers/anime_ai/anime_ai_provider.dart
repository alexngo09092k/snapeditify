import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
import 'package:phosart/view_models/editing_image.dart';
import 'package:phosart/widgets/painter/painter.dart';

abstract class IAnimeAIProvider extends EditImageProvider with StorageProvider {
  List<AnimeStyle> get styles;

  bool get canSave;
  bool get canRevert;
  bool get canCompare;

  Future<bool> restyleImage(String styleId);
  Future<bool> videoEffect(String styleId);

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

  late AnimeAIState _state;
  @override
  AnimeAIState get state => _state;

  @override
  EditingImage get editedImage => _state.image;

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
  Future<bool> restyleImage(String styleId) async {
    if (_state.styledImages.containsKey(styleId)) {
      _state.setImage(_state.styledImages[styleId]!.outputImages.first.image, styleId: styleId);
      notifyListeners();
      return true;
    }

    /// SHOW LOADING POPUP
    SmartDialog.showLoading();

    /// CALL API
    AnimeAIImageBody body = AnimeAIImageBody(style: styleId, inputImage: originalImage.imageBytes);
    SnapEditResponse<AnimeImageResponse?> res = await Services.instance.snapEdit.animeRestyle(body);

    Debug.log(res.data!.outputImages.first.imageId);

    if (res.data != null) {
      await _state.setImage(res.data!.outputImages.first.image, styleId: styleId);
      _state.styledImages[styleId] = res.data!;
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
  Future<bool> videoEffect(String styleId) async {
    await restyleImage(styleId);
    // if (_state.styledImages.containsKey(styleId)) {
    //   _state.setImage(_state.styledImages[styleId]!, styleId: styleId);
    //   notifyListeners();
    //   return true;
    // }

    /// SHOW LOADING POPUP
    SmartDialog.showLoading();

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
  Future<bool> saveImage(BuildContext context) async {
    return checkoutSaveImage(context, () async {
      /// SAVE IMAGE
      return true;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
    });
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = AnimeAIState();
    _state.addListener(notifyListeners);
    return true;
  }

  @override
  Uint8List get editedImageBytes => throw UnimplementedError();
}
