import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/models/config/gallery_config.dart';
import 'package:snapedit/providers/gallery_provider.dart';

enum PhotosFor {
  removeObject,
  enhanceImage,
  applyArtEffect,
}

abstract class IPhotoProvider extends Provider with ProviderDelegate {
  PhotosFor photosFor = PhotosFor.removeObject;

  List<String> get suggestedImages;

  AssetPathEntity? get album;

  List<AssetEntity> get photos;

  int get page;

  int get total;

  bool get refreshing;

  Future<bool> setAlbum(AssetPathEntity album);

  Future<bool> onRefresh();

  Future<bool> onLoadMore();
}

class PhotoProvider extends IPhotoProvider {
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

  Map<PhotosFor, List<String>> suggestedImagesStore = {
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
  List<String> get suggestedImages => suggestedImagesStore[_photosFor] ?? [];

  GalleryConfig get _config => ManagerProvider.of<GalleryProvider>().config;

  int _page = 0;
  @override
  int get page => _page;

  bool _refreshing = false;
  @override
  bool get refreshing => _refreshing;

  AssetPathEntity? _album;

  @override
  AssetPathEntity? get album => _album;

  @override
  Future<bool> setAlbum(AssetPathEntity album) async {
    _album = album;
    onRefresh();
    notifyListeners();
    return true;
  }

  final List<AssetEntity> _photos = [];
  @override
  List<AssetEntity> get photos => _photos;

  int _total = 0;
  @override
  int get total => _total;

  @override
  Future<bool> onRefresh() async {
    if (refreshing) return false;
    if (_album == null) return false;
    _refreshing = true;

    _album = await _album!.obtainForNewProperties(maxDateTimeToNow: false);
    _total = await _album!.assetCountAsync;
    _page = 1;

    _photos.clear();
    _photos.addAll(await album!.getAssetListPaged(page: _page, size: _config.countInPage));

    _refreshing = false;
    notifyListeners();
    return true;
  }

  @override
  Future<bool> onLoadMore() async {
    if (refreshing) return false;
    if (_album == null) return false;
    if (_photos.length + 1 > total) return false;

    _page += 1;
    _photos.addAll(await album!.getAssetListPaged(page: _page, size: _config.countInPage));
    notifyListeners();

    return true;
  }
}
