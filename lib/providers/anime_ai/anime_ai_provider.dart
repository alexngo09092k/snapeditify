import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/edit_image_state.dart';
import 'package:snapedit/providers/storage_provider.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/services/snap_edit/src/models/response/anime_styles_response.dart';

abstract class IAnimeAIProvider extends EditImageProvider with StorageProvider {
  List<AnimeStyle> get styles;
}

class AnimeAIProvider extends IAnimeAIProvider with ProviderDelegate {
  static final IAnimeAIProvider _instance = AnimeAIProvider.internal();

  static IAnimeAIProvider get instance => _instance;

  AnimeAIProvider.internal();

  final List<AnimeStyle> _styles = [];
  @override
  List<AnimeStyle> get styles => _styles;

  @override
  EditImageState get state => throw UnimplementedError();

  @override
  Future<bool> refresh(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveImage(BuildContext context) {
    throw UnimplementedError();
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
}
