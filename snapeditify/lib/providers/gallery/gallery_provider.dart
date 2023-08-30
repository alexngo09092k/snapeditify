import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/models/config/gallery_config.dart';
import 'package:snapeditify/view_models/album_vm.dart';

enum ImageTool {
  removePeople,
  oneTouchRemoveAll,

  enhancePortrait,
  upscaleImage,
  restoreOldPhoto,

  makeIDPassportPhoto,
  productPhoto,
  changeBackground,

  createAnimeAI,
  applyArtEffect,
  changeYourSky,
}

extension ImageToolEX on ImageTool {
  String get title {
    switch (this) {
      case ImageTool.removePeople:
        return 'Remove People';
      case ImageTool.oneTouchRemoveAll:
        return '1-Touch Remove All';
      case ImageTool.enhancePortrait:
        return 'Enhance Portrait';
      case ImageTool.upscaleImage:
        return 'Upscale Image';
      case ImageTool.restoreOldPhoto:
        return 'Restore Old Photo';
      case ImageTool.makeIDPassportPhoto:
        return 'Make ID Passport Photo';
      case ImageTool.productPhoto:
        return 'Product Photo';
      case ImageTool.changeBackground:
        return 'Change Background';
      case ImageTool.createAnimeAI:
        return 'Create Anime AI';
      case ImageTool.applyArtEffect:
        return 'Apply Art Effect';
      case ImageTool.changeYourSky:
        return 'Change Sky';
      default:
        throw 'Image Tool Not Found';
    }
  }
}

extension ImageToolEX2 on ImageTool {
  String get image {
    switch (this) {
      case ImageTool.removePeople:
        return AppAssets.instance.removePeople;
      case ImageTool.oneTouchRemoveAll:
        return AppAssets.instance.oneTouchRemoveAll;
      case ImageTool.enhancePortrait:
        return AppAssets.instance.enhancePortrait;
      case ImageTool.upscaleImage:
        return AppAssets.instance.upscaleImage;
      case ImageTool.restoreOldPhoto:
        return AppAssets.instance.restorePhoto;
      case ImageTool.makeIDPassportPhoto:
        return AppAssets.instance.makeIDPassport;
      case ImageTool.productPhoto:
        return AppAssets.instance.productPhoto;
      case ImageTool.changeBackground:
        return AppAssets.instance.changeBackground;
      case ImageTool.createAnimeAI:
        return AppAssets.instance.createAnimeAI;
      case ImageTool.applyArtEffect:
        return AppAssets.instance.applyEffect;
      case ImageTool.changeYourSky:
        return AppAssets.instance.changeYourSky;
      default:
        throw 'Image Tool Not Found';
    }
  }
}

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<String, AlbumVM> get albumList;

  GalleryConfig get config;

  ImageTool imageTool = ImageTool.removePeople;

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

  ImageTool _imageTool = ImageTool.removePeople;

  @override
  ImageTool get imageTool => _imageTool;

  @override
  set imageTool(ImageTool value) {
    if (_imageTool != value) {
      _imageTool = value;
      notifyListeners();
    }
  }

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
      final String name = '${Configuration.instance.business.appName}_${DateTime.now().millisecond}';
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

        if (result != null && result['filePath'] != null && await imageFile.exists()) {
          /// REFRESH IMAGE
          await refreshGalleryList(true);

          return imageFile;
        }
      } else {
        AssetEntity? asset = await PhotoManager.editor.saveImage(
          data,
          title: '${Configuration.instance.business.appName}_${DateTime.now().millisecond}',
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
