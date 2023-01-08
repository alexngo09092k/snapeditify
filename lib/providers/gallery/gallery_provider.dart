import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/models/config/gallery_config.dart';

enum EditImageType {
  removeObject,
  enhanceImage,
  applyArtEffect,
  animeAI,
}

extension EditImageTypeEX on EditImageType {
  get icon {
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
    }
  }

  get title {
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
    }
  }
}

enum ImageSource {
  inSuggesstedPhotos,
  inAlbum,
}

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<AssetPathEntity, int> get albumList;

  GalleryConfig get config;

  EditImageType photosFor = EditImageType.removeObject;

  List<String> get suggestedPhotos;

  Future<bool> initial(GalleryConfig config);

  Future<bool> refreshGalleryList();
}

class GalleryProvider extends IGalleryProvider {
  static final IGalleryProvider _instance = GalleryProvider.internal();

  static IGalleryProvider get instance => _instance;

  GalleryProvider.internal();

  GalleryConfig _config = GalleryConfig.defaultValue();

  @override
  GalleryConfig get config => _config;

  final Map<AssetPathEntity, int> _albumList = {};

  @override
  Map<AssetPathEntity, int> get albumList => _albumList;

  EditImageType _photosFor = EditImageType.removeObject;

  @override
  EditImageType get photosFor => _photosFor;

  @override
  set photosFor(EditImageType value) {
    if (_photosFor != value) {
      _photosFor = value;
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
      AppAssets.instance.snapEditEnhanceDemo1,
      AppAssets.instance.snapEditEnhanceDemo2,
      AppAssets.instance.snapEditEnhanceDemo3,
    ],
    EditImageType.removeObject: [
      AppAssets.instance.snapEditDemo1,
      AppAssets.instance.snapEditDemo2,
      AppAssets.instance.snapEditDemo3,
    ],
    EditImageType.animeAI: [
      AppAssets.instance.animeDemo1,
      AppAssets.instance.animeDemo2,
      AppAssets.instance.animeDemo3,
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
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
      Debug.log("Hello");
    }

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
