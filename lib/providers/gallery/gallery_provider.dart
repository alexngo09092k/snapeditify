import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/models/config/gallery_config.dart';
import 'package:snapeditify/view_models/album_vm.dart';

enum EditImageType {
  removeObject,
  enhanceImage,
  applyArtEffect,
  animeAI,
}

extension EditImageTypeEX on EditImageType {
  String get icon {
    switch (this) {
      case EditImageType.animeAI:
        return AppAssets.instance.icAI;
      case EditImageType.removeObject:
        return AppAssets.instance.icRemoveObject;
      case EditImageType.applyArtEffect:
        return AppAssets.instance.icArtEffect;
      case EditImageType.enhanceImage:
        return AppAssets.instance.icEnhence;
      default:
        throw 'Edit Image Type Not Found';
    }
  }

  String get title {
    switch (this) {
      case EditImageType.animeAI:
        return 'Anime AI';
      case EditImageType.removeObject:
        return 'Remove';
      case EditImageType.applyArtEffect:
        return 'Art Effect';
      case EditImageType.enhanceImage:
        return 'Enhance';
      default:
        throw 'Edit Image Type Not Found';
    }
  }

  EditImageProvider get provider {
    switch (this) {
      case EditImageType.animeAI:
        return ManagerProvider.of<AnimeAIProvider>();
      case EditImageType.removeObject:
        return ManagerProvider.of<RemoveObjectProvider>();
      case EditImageType.applyArtEffect:
        return ManagerProvider.of<RestyleProvider>();
      case EditImageType.enhanceImage:
        return ManagerProvider.of<EnhanceProvider>();
      default:
        throw 'Edit Image Type Not Found';
    }
  }
}

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<String, AlbumVM> get albumList;

  GalleryConfig get config;

  EditImageType editImageType = EditImageType.removeObject;

  List<String> get suggestedPhotos;

  Future<bool> initial(GalleryConfig config);

  Future<bool> refreshGalleryList();

  Future<File?> saveImage(Uint8List data);

  Future<void> clearCache();
}

class GalleryProvider extends IGalleryProvider {
  static final IGalleryProvider _instance = GalleryProvider.internal();

  static IGalleryProvider get instance => _instance;

  GalleryProvider.internal() {
    PhotoManager.startChangeNotify();
    PhotoManager.addChangeCallback(_listenChangePhotos);
  }

  GalleryConfig _config = GalleryConfig.defaultValue();

  @override
  GalleryConfig get config => _config;

  final Map<String, AlbumVM> _albumList = {};

  @override
  Map<String, AlbumVM> get albumList => _albumList;

  EditImageType _editImageType = EditImageType.removeObject;

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
    EditImageType.applyArtEffect: [
      AppAssets.instance.restyleDemo1,
      AppAssets.instance.restyleDemo2,
      AppAssets.instance.restyleDemo3,
    ],
    EditImageType.enhanceImage: [
      AppAssets.instance.enhanceDemo1,
      AppAssets.instance.enhanceDemo2,
      AppAssets.instance.enhanceDemo3,
    ],
    EditImageType.removeObject: [
      AppAssets.instance.removeObjectDemo1,
      AppAssets.instance.removeObjectDemo2,
      AppAssets.instance.removeObjectDemo3,
    ],
    EditImageType.animeAI: [
      AppAssets.instance.animeDemo1,
      AppAssets.instance.animeDemo2,
      AppAssets.instance.animeDemo3,
    ],
  };

  @override
  List<String> get suggestedPhotos => suggestedPhotosStore[_editImageType] ?? [];

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
      final acount = await entityPath.assetCountAsync;
      _albumList[entityPath.id] = AlbumVM(
        entityPath: entityPath,
        thumnail: entities.isNotEmpty ? entities.first : null,
        count: acount,
      );
    }

    if (notify) notifyListeners();

    return true;
  }

  @override
  Future<File?> saveImage(Uint8List data) async {
    AssetEntity? asset = await PhotoManager.editor.saveImage(
      data,
      title: '${Configuration.instance.business.appName}_${DateTime.now().millisecond}',
    );
    return asset?.file;
  }

  @override
  Future<void> clearCache() {
    return PhotoManager.clearFileCache();
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
