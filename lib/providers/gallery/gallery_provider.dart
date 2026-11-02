import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/models/config/gallery_config.dart';
import 'package:snapeditify/view_models/album_vm.dart';
import 'package:snapeditify/generated/l10n.dart';

enum ImageTool {
  removeObject,
  oneTouchRemoveAll,

  enhanceImage,
  upscaleImage,
  restoreOldPhoto,

  // makeIDPassportPhoto,
  // productPhoto,
  // changeBG,

  generateAnimeAI,
  applyArtEffect,
  changeYourSky,

  fastEditor,
}

extension ImageToolEX on ImageTool {
  String title(BuildContext context) {
    final s = S.of(context);
    switch (this) {
      case ImageTool.removeObject:
        return s.removeObject;
      case ImageTool.oneTouchRemoveAll:
        return s.oneTouchRemove;
      case ImageTool.enhanceImage:
        return s.enhanceImage;
      case ImageTool.upscaleImage:
        return s.upscaleImage;
      case ImageTool.restoreOldPhoto:
        return s.restoreOldPhoto;
      case ImageTool.generateAnimeAI:
        return s.animeAi;
      case ImageTool.applyArtEffect:
        return s.artEffect;
      case ImageTool.changeYourSky:
        return s.changeSky;
      case ImageTool.fastEditor:
        return s.fastEditor;
    }
  }

  String shortTitle(BuildContext context) {
    final s = S.of(context);
    switch (this) {
      case ImageTool.removeObject:
        return s.remover;
      case ImageTool.oneTouchRemoveAll:
        return s.oneTouch;
      case ImageTool.enhanceImage:
        return s.enhance;
      case ImageTool.upscaleImage:
        return s.upscale;
      case ImageTool.restoreOldPhoto:
        return s.restore;
      case ImageTool.generateAnimeAI:
        return s.animeAi;
      case ImageTool.applyArtEffect:
        return s.artEffect;
      case ImageTool.changeYourSky:
        return s.sky;
      case ImageTool.fastEditor:
        return s.editor;
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
      // case ImageTool.makeIDPassportPhoto:
      //   return AppAssets.instance.makeIDPassport;
      // case ImageTool.productPhoto:
      //   return AppAssets.instance.productPhoto;
      // case ImageTool.changeBG:
      //   return AppAssets.instance.changeBackground;
      case ImageTool.generateAnimeAI:
        return AppAssets.instance.generateAnimeAI;
      case ImageTool.applyArtEffect:
        return AppAssets.instance.applyEffect;
      case ImageTool.changeYourSky:
        return AppAssets.instance.changeYourSky;
      case ImageTool.fastEditor:
        return AppAssets.instance.icEditor;
    }
  }

  String get icon {
    switch (this) {
      case ImageTool.removeObject:
        return AppAssets.instance.icRemoveObject;
      case ImageTool.oneTouchRemoveAll:
        return AppAssets.instance.icOneTouch;
      case ImageTool.enhanceImage:
        return AppAssets.instance.icEnhance;
      case ImageTool.upscaleImage:
        return AppAssets.instance.icEnhance;
      case ImageTool.restoreOldPhoto:
        return AppAssets.instance.icRestoration;
      // case ImageTool.makeIDPassportPhoto:
      //   return AppAssets.instance.icEnhance;
      // case ImageTool.productPhoto:
      //   return AppAssets.instance.icRemoveBG;
      // case ImageTool.changeBG:
      //   return AppAssets.instance.icRemoveBG;
      case ImageTool.generateAnimeAI:
        return AppAssets.instance.icAnimeAI;
      case ImageTool.applyArtEffect:
        return AppAssets.instance.icArtEffect;
      case ImageTool.changeYourSky:
        return AppAssets.instance.icSky;
      case ImageTool.fastEditor:
        return AppAssets.instance.icEditor;
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
      // case ImageTool.makeIDPassportPhoto:
      //   return const Color.fromRGBO(201, 226, 236, 1);
      // case ImageTool.productPhoto:
      //   return const Color.fromRGBO(252, 240, 245, 1);
      // case ImageTool.changeBG:
      //   return const Color.fromRGBO(241, 224, 165, 1);
      case ImageTool.generateAnimeAI:
        return const Color.fromRGBO(206, 250, 220, 1);
      case ImageTool.applyArtEffect:
        return const Color.fromRGBO(252, 245, 230, 1);
      case ImageTool.changeYourSky:
        return const Color.fromRGBO(214, 241, 247, 1);
      case ImageTool.fastEditor:
        return const Color.fromRGBO(223, 244, 234, 1);
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

  Future<bool> refreshGalleryList([bool notify = true]);

  Future<File?> saveImage(Uint8List data);

  Future<File?> saveVideo(String videoURL);

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
      AppAssets.instance.removeObject1,
      AppAssets.instance.removeObject2,
      AppAssets.instance.removeObject3,
    ],
    ImageTool.oneTouchRemoveAll: [
      AppAssets.instance.removeObject1,
      AppAssets.instance.removeObject2,
      AppAssets.instance.removeObject3,
    ],
    ImageTool.enhanceImage: [
      AppAssets.instance.enhance1,
      AppAssets.instance.enhance2,
      AppAssets.instance.enhance3,
    ],
    ImageTool.upscaleImage: [
      AppAssets.instance.enhance1,
      AppAssets.instance.enhance2,
      AppAssets.instance.enhance3,
    ],
    ImageTool.restoreOldPhoto: [
      AppAssets.instance.restore1,
      AppAssets.instance.restore2,
      AppAssets.instance.restore3,
    ],
    // ImageTool.makeIDPassportPhoto: [
    //   AppAssets.instance.passportMaker1,
    //   AppAssets.instance.passportMaker2,
    //   AppAssets.instance.passportMaker3,
    // ],
    // ImageTool.productPhoto: [
    //   AppAssets.instance.removeBG1,
    //   AppAssets.instance.removeBG2,
    //   AppAssets.instance.removeBG3,
    // ],
    // ImageTool.changeBG: [
    //   AppAssets.instance.removeBG1,
    //   AppAssets.instance.removeBG2,
    //   AppAssets.instance.removeBG3,
    // ],
    ImageTool.generateAnimeAI: [
      AppAssets.instance.anime1,
      AppAssets.instance.anime2,
      AppAssets.instance.anime3,
    ],
    ImageTool.applyArtEffect: [
      AppAssets.instance.restyle1,
      AppAssets.instance.restyle2,
      AppAssets.instance.restyle3,
    ],
    ImageTool.changeYourSky: [
      AppAssets.instance.sky1,
      AppAssets.instance.sky2,
      AppAssets.instance.sky3,
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
        final result = await ImageGallerySaverPlus.saveImage(
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
          filename:
              '${Configuration.instance.business.appName}_${DateTime.now().millisecond}',
          title: Configuration.instance.business.appName,
        );
        return asset.file;
      }
    } catch (error) {
      Debug.log(error);
    }
    return null;
  }

  @override
  Future<File?> saveVideo(String videoURL) async {
    try {
      final String name =
          '${Configuration.instance.business.appName}_${DateTime.now().millisecond}';

      // final Directory dataDirectory = await getApplicationDocumentsDirectory();
      final Directory cacheDirectory = await getTemporaryDirectory();
      String savePath = "${cacheDirectory.path}/$name.mp4";
      File videoFile = File(savePath);
      await Dio().download(videoURL, savePath);

      if (CurrentPlatform.instance.isHuawei) {
        final result = await ImageGallerySaverPlus.saveFile(
          savePath,
          name: '$name.mp4',
        );

        if (result != null &&
            result['filePath'] != null &&
            await videoFile.exists()) {
          /// REFRESH IMAGE
          await refreshGalleryList(true);

          return videoFile;
        }
      } else {
        AssetEntity? asset = await PhotoManager.editor.saveVideo(
          videoFile,
          title: '$name.mp4',
        );
        return asset.file;
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
