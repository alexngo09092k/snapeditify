import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/models/config/gallery_config.dart';
import 'package:snapeditify/providers/sky/sky_provider.dart';
import 'package:snapeditify/view_models/album_vm.dart';

enum EditImageType {
  remover,
  oneTouch,
  enhance,
  removeBackground,
  animeAI,
  artEffect,
  restore,
  sky,
}

extension EditImageTypeEX on EditImageType {
  String get icon {
    switch (this) {
      case EditImageType.remover:
        return AppAssets.instance.icRemoveObject;
      case EditImageType.oneTouch:
        return AppAssets.instance.icRemoveObject;
      case EditImageType.enhance:
        return AppAssets.instance.icEnhence;
      case EditImageType.removeBackground:
        return AppAssets.instance.icEnhence;
      case EditImageType.animeAI:
        return AppAssets.instance.icAnimeAI;
      case EditImageType.artEffect:
        return AppAssets.instance.icArtEffect;
      case EditImageType.restore:
        return AppAssets.instance.icArtEffect;
      case EditImageType.sky:
        return AppAssets.instance.icArtEffect; 
      default:
        throw 'Edit Image Type Not Found';
    }
  }

  String get title {
    switch (this) {
      case EditImageType.remover:
        return 'Remover';
      case EditImageType.oneTouch:
        return '1 Touch';
      case EditImageType.enhance:
        return 'Enhance';
      case EditImageType.removeBackground:
        return 'Remove BG';
      case EditImageType.animeAI:
        return 'Anime AI';
      case EditImageType.artEffect:
        return 'Art Effect';
      case EditImageType.restore:
        return 'Restore';
      case EditImageType.sky:
        return 'Sky';
      default:
        throw 'Edit Image Type Not Found';
    }
  }

  EditImageProvider get provider {
    switch (this) {
      case EditImageType.remover:
      case EditImageType.oneTouch:
        return ManagerProvider.of<RemoverProvider>();
      case EditImageType.enhance:
        return ManagerProvider.of<EnhanceProvider>();
      case EditImageType.animeAI:
        return ManagerProvider.of<AnimeAIProvider>();
      case EditImageType.artEffect:
        return ManagerProvider.of<RestyleProvider>();
      case EditImageType.sky:
        return ManagerProvider.of<SkyProvider>();
      default:
        throw 'Edit Image Type Not Found';
    }
  }
}

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<String, AlbumVM> get albumList;

  GalleryConfig get config;

  EditImageType editImageType = EditImageType.remover;

  List<String> get suggestedPhotos;

  Future<bool> initial(GalleryConfig config);

  Future<bool> refreshGalleryList();

  Future<File?> saveImage(Uint8List data);

  Future<void> clearCache();

  Future<void> listenPhotos();
}

class GalleryProvider extends IGalleryProvider {
  static final IGalleryProvider _instance = GalleryProvider.internal();

  static IGalleryProvider get instance => _instance;

  GalleryProvider.internal();

  GalleryConfig _config = GalleryConfig.defaultValue();

  @override
  GalleryConfig get config => _config;

  final Map<String, AlbumVM> _albumList = {};

  @override
  Map<String, AlbumVM> get albumList => _albumList;

  EditImageType _editImageType = EditImageType.remover;

  @override
  EditImageType get editImageType => _editImageType;

  @override
  set editImageType(EditImageType value) {
    if (_editImageType != value) {
      _editImageType = value;
      notifyListeners();
    }
  }

  Map<EditImageType, List<String>> suggestedPhotosStore = {
    EditImageType.artEffect: [
      AppAssets.instance.restyleDemo1,
      AppAssets.instance.restyleDemo2,
      AppAssets.instance.restyleDemo3,
    ],
    EditImageType.enhance: [
      AppAssets.instance.enhanceDemo1,
      AppAssets.instance.enhanceDemo2,
      AppAssets.instance.enhanceDemo3,
    ],
    EditImageType.remover: [
      AppAssets.instance.removeObjectDemo1,
      AppAssets.instance.removeObjectDemo2,
      AppAssets.instance.removeObjectDemo3,
    ],
    EditImageType.animeAI: [
      AppAssets.instance.animeDemo1,
      AppAssets.instance.animeDemo2,
      AppAssets.instance.animeDemo3,
    ],
    EditImageType.sky: [
      AppAssets.instance.animeDemo1,
      AppAssets.instance.animeDemo2,
      AppAssets.instance.animeDemo3,
    ],
    EditImageType.restore: [
      AppAssets.instance.animeDemo1,
      AppAssets.instance.animeDemo2,
      AppAssets.instance.animeDemo3,
    ],
  };

  @override
  List<String> get suggestedPhotos =>
      suggestedPhotosStore[_editImageType] ?? [];

  late final StreamController<dynamic> _controller;

  @override
  Future<bool> initial(GalleryConfig config) async {
    _config = config;
    return true;
  }

  @override
  Future<bool> refreshGalleryList([bool notify = true]) async {
    final entityPaths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: _config.hasAll,
      onlyAll: _config.onlyAll,
      filterOption: _config.option,
    );

    for (var entityPath in entityPaths) {
      final entities = (await entityPath.getAssetListPaged(page: 0, size: 1));
      final count = await entityPath.assetCountAsync;
      if (count < 1) continue;
      _albumList[entityPath.id] = AlbumVM(
        entityPath: entityPath,
        thumnail: entities.isNotEmpty ? entities.first : null,
        count: count,
      );
    }

    if (notify) notifyListeners();

    return true;
  }

  @override
  Future<File?> saveImage(Uint8List data) async {
    try {
      final String name =
          '${Configuration.instance.business.appName}_${DateTime.now().millisecond}';
      if (CurrentPlatform.instance.isHuawei) {
        final result = await ImageGallerySaver.saveImage(
          data,
          quality: 100,
          name: name,
          isReturnImagePathOfIOS: CurrentPlatform.instance.isIos,
        );
        // final Directory dataDirectory = await getApplicationDocumentsDirectory();
        final Directory cacheDirectory = await getTemporaryDirectory();

        /// IMAGE FILE
        final File imageFile = File('${cacheDirectory.path}/$name.jpg');
        imageFile.writeAsBytesSync(data);

        if (result != null &&
            result['filePath'] != null &&
            await imageFile.exists()) {
          /// REFRESH IMAGE
          await refreshGalleryList(true);

          return imageFile;
        }
      } else {
        AssetEntity? asset = await PhotoManager.editor.saveImage(
          data,
          title:
              '${Configuration.instance.business.appName}_${DateTime.now().millisecond}',
        );
        return asset?.file;
      }
    } catch (error) {
      Debug.log(error);
    }
    return null;
  }

  @override
  Future<void> clearCache() {
    return PhotoManager.clearFileCache();
  }

  bool _listened = false;
  @override
  Future<void> listenPhotos() async {
    if (_listened) return;
    PhotoManager.startChangeNotify();
    PhotoManager.addChangeCallback(_listenChangePhotos);
    _listened = true;
    return;
  }

  _listenChangePhotos(_) {
    Debug.log("====== PHOTOS CHANGED ======");
    refreshGalleryList(true);
  }

  @override
  void dispose() {
    PhotoManager.removeChangeCallback(_listenChangePhotos);
    PhotoManager.stopChangeNotify();
    _controller.close();
    clearCache();
    super.dispose();
  }
}
