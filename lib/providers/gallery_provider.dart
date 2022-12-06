import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/models/config/gallery_config.dart';

enum PhotosFor {
  removeObject,
  enhanceImage,
  applyArtEffect,
}

enum PhotosType {
  inSuggesstedPhotos,
  inAlbum,
}

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<AssetPathEntity, int> get albumList;

  GalleryConfig get config;

  PhotosFor photosFor = PhotosFor.removeObject;

  List<String> get suggestedPhotos;

  Future<bool> initial(GalleryConfig config);

  Future<bool> refreshGalleryList();
}

class GalleryProvider extends IGalleryProvider {
  GalleryConfig _config = GalleryConfig.defaultValue();

  @override
  GalleryConfig get config => _config;

  final Map<AssetPathEntity, int> _albumList = {};

  @override
  Map<AssetPathEntity, int> get albumList => _albumList;

  PhotosFor _photosFor = PhotosFor.removeObject;

  @override
  PhotosFor get photosFor => _photosFor;

  @override
  set photosFor(PhotosFor value) {
    if (_photosFor != value) {
      _photosFor = value;
      notifyListeners();
    }
  }

  Map<PhotosFor, List<String>> suggestedPhotosStore = {
    PhotosFor.applyArtEffect: [
      AppAssets.instance.restyleDemo1,
      AppAssets.instance.restyleDemo2,
      AppAssets.instance.restyleDemo3,
    ],
    PhotosFor.enhanceImage: [
      AppAssets.instance.snapEditEnhanceDemo1,
      AppAssets.instance.snapEditEnhanceDemo2,
      AppAssets.instance.snapEditEnhanceDemo3,
    ],
    PhotosFor.removeObject: [
      AppAssets.instance.snapEditDemo1,
      AppAssets.instance.snapEditDemo2,
      AppAssets.instance.snapEditDemo3,
    ],
  };

  @override
  List<String> get suggestedPhotos => suggestedPhotosStore[_photosFor] ?? [];

  @override
  Future<bool> initial(GalleryConfig config) async {
    _config = config;
    return true;
  }

  @override
  Future<bool> refreshGalleryList() async {
    // final PermissionState ps = await PhotoManager.requestPermissionExtend();
    // if(!ps.hasAccess) {
    //   Debug.log("Hello");
    // }

    final List<AssetPathEntity> albumList = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: _config.hasAll,
      onlyAll: _config.onlyAll,
      filterOption: _config.option,
    );

    _albumList.clear();

    for (var album in albumList) {
      _albumList[album] = await album.assetCountAsync;
    }

    return true;
  }

  @override
  Future<bool> registered() async {
    ///SET GALLERY LIST
    refreshGalleryList();
    return super.registered();
  }
}
