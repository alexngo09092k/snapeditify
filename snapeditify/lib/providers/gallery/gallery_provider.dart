import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/models/config/gallery_config.dart';
import 'package:snapeditify/view_models/album_vm.dart';

enum ImageTool {
  removeObject,
  oneTouchRemoveAll,

  enhanceImage,
  upscaleImage,
  restoreOldPhoto,

  makeIDPassportPhoto,
  productPhoto,
  changeBackground,

  generateAnimeAI,
  applyArtEffect,
  changeYourSky,
}

extension ImageToolEX on ImageTool {
  String get title {
    switch (this) {
      case ImageTool.removeObject:
        return 'Remove Object';
      case ImageTool.oneTouchRemoveAll:
        return '1-Touch Remove';
      case ImageTool.enhanceImage:
        return 'Enhance Image';
      case ImageTool.upscaleImage:
        return 'Upscale Image';
      case ImageTool.restoreOldPhoto:
        return 'Restore Old Photo';
      case ImageTool.makeIDPassportPhoto:
        return 'Make ID Passport';
      case ImageTool.productPhoto:
        return 'Product Photo';
      case ImageTool.changeBackground:
        return 'Change Background';
      case ImageTool.generateAnimeAI:
        return 'Generate Anime AI';
      case ImageTool.applyArtEffect:
        return 'Apply Art Effect';
      case ImageTool.changeYourSky:
        return 'Change Sky';
    }
  }

  String get shortTitle {
    switch (this) {
      case ImageTool.removeObject:
        return 'Remover';
      case ImageTool.oneTouchRemoveAll:
        return '1-Touch';
      case ImageTool.enhanceImage:
        return 'Enhance';
      case ImageTool.upscaleImage:
        return 'Upscale';
      case ImageTool.restoreOldPhoto:
        return 'Restore';
      case ImageTool.makeIDPassportPhoto:
        return 'Make ID';
      case ImageTool.productPhoto:
        return 'Product';
      case ImageTool.changeBackground:
        return 'Change BG';
      case ImageTool.generateAnimeAI:
        return 'Anime AI';
      case ImageTool.applyArtEffect:
        return 'Art Effect';
      case ImageTool.changeYourSky:
        return 'Sky';
    }
  }

  String get image {
    switch (this) {
      case ImageTool.removeObject:
        return AppAssets.instance.removeObject;
      case ImageTool.oneTouchRemoveAll:
        return AppAssets.instance.oneTouchRemoveAll;
      case ImageTool.enhanceImage:
        return AppAssets.instance.enhanceImage;
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
      case ImageTool.generateAnimeAI:
        return AppAssets.instance.generateAnimeAI;
      case ImageTool.applyArtEffect:
        return AppAssets.instance.applyEffect;
      case ImageTool.changeYourSky:
        return AppAssets.instance.changeYourSky;
    }
  }

  String get icon {
    switch (this) {
      case ImageTool.removeObject:
        return AppAssets.instance.icRemoveObject;
      case ImageTool.oneTouchRemoveAll:
        return AppAssets.instance.icAI;
      case ImageTool.enhanceImage:
        return AppAssets.instance.icEnhence;
      case ImageTool.upscaleImage:
        return AppAssets.instance.icEnhence;
      case ImageTool.restoreOldPhoto:
        return AppAssets.instance.icEnhence;
      case ImageTool.makeIDPassportPhoto:
        return AppAssets.instance.icEnhence;
      case ImageTool.productPhoto:
        return AppAssets.instance.icAI;
      case ImageTool.changeBackground:
        return AppAssets.instance.icAI;
      case ImageTool.generateAnimeAI:
        return AppAssets.instance.icAI;
      case ImageTool.applyArtEffect:
        return AppAssets.instance.icAI;
      case ImageTool.changeYourSky:
        return AppAssets.instance.icAI;
    }
  }

  Color get color {
    switch (this) {
      case ImageTool.removeObject:
        return const Color.fromRGBO(236, 223, 253, 1);
      case ImageTool.oneTouchRemoveAll:
        return const Color.fromRGBO(212, 229, 255, 1);
      case ImageTool.enhanceImage:
        return const Color.fromRGBO(252, 237, 252, 1); 
      case ImageTool.upscaleImage:
        return const Color.fromRGBO(223, 244, 234, 1);
      case ImageTool.restoreOldPhoto:
        return const Color.fromRGBO(237, 240, 202, 1);
      case ImageTool.makeIDPassportPhoto:
        return const Color.fromRGBO(201, 226, 236, 1);
      case ImageTool.productPhoto:
        return const Color.fromRGBO(252, 240, 245, 1);
      case ImageTool.changeBackground:
        return const Color.fromRGBO(241, 224, 165, 1);
      case ImageTool.generateAnimeAI:
        return const Color.fromRGBO(206, 250, 220, 1); 
      case ImageTool.applyArtEffect:
        return const Color.fromRGBO(252, 245, 230, 1);
      case ImageTool.changeYourSky:
        return const Color.fromRGBO(214, 241, 247, 1);
    }
  }
}

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<String, AlbumVM> get albumList;

  GalleryConfig get config;

  ImageTool imageTool = ImageTool.removeObject;

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

  ImageTool _imageTool = ImageTool.removeObject;

  @override
  ImageTool get imageTool => _imageTool;

  @override
  set imageTool(ImageTool value) {
    if (_imageTool != value) {
      _imageTool = value;
      notifyListeners();
    }
  }

  Map<ImageTool, List<String>> suggestedPhotosStore = {
    ImageTool.removeObject: [
      AppAssets.instance.rmb1,
      AppAssets.instance.rmb2,
      AppAssets.instance.rmb3,
    ],
    ImageTool.oneTouchRemoveAll: [
      AppAssets.instance.rmots1,
      AppAssets.instance.rmots2,
      AppAssets.instance.rmots3,
    ],
    ImageTool.enhanceImage: [
      AppAssets.instance.e1,
      AppAssets.instance.e2,
      AppAssets.instance.e3,
    ],
    ImageTool.upscaleImage: [
      AppAssets.instance.e1,
      AppAssets.instance.e2,
      AppAssets.instance.e3,
    ],
    ImageTool.restoreOldPhoto: [
      AppAssets.instance.rs1,
      AppAssets.instance.rs2,
      AppAssets.instance.rs3,
    ],
    ImageTool.makeIDPassportPhoto: [
      AppAssets.instance.rmbg1,
      AppAssets.instance.rmbg2,
      AppAssets.instance.rmbg3,
    ],
    ImageTool.productPhoto: [
      AppAssets.instance.csk1,
      AppAssets.instance.csk2,
      AppAssets.instance.csk3,
    ],
    ImageTool.changeBackground: [
      AppAssets.instance.csk1,
      AppAssets.instance.csk2,
      AppAssets.instance.csk3,
    ],
    ImageTool.generateAnimeAI: [
      AppAssets.instance.csk1,
      AppAssets.instance.csk2,
      AppAssets.instance.csk3,
    ],
    ImageTool.applyArtEffect: [
      AppAssets.instance.csk1,
      AppAssets.instance.csk2,
      AppAssets.instance.csk3,
    ],
    ImageTool.changeYourSky: [
      AppAssets.instance.csk1,
      AppAssets.instance.csk2,
      AppAssets.instance.csk3,
    ],
  };

  @override
  List<String> get suggestedPhotos => suggestedPhotosStore[imageTool] ?? [];

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
