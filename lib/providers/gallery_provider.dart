import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/models/config/gallery_config.dart';

abstract class IGalleryProvider extends Provider with ProviderDelegate {
  /// GALLERY LIST <ALBUM>
  Map<AssetPathEntity, List<AssetEntity>> get albumList;

  GalleryConfig get config;

  Future<bool> initial(GalleryConfig config);

  Future<bool> refreshGalleryList();
}

class GalleryProvider extends IGalleryProvider {
  GalleryConfig _config = GalleryConfig.defaultValue();

  @override
  GalleryConfig get config => _config;

  final Map<AssetPathEntity, List<AssetEntity>> _albumList = {};

  @override
  Map<AssetPathEntity, List<AssetEntity>> get albumList => _albumList;

  @override
  Future<bool> initial(GalleryConfig config) async {
    _config = config;
    return true;
  }

  @override
  Future<bool> refreshGalleryList() async {
    final List<AssetPathEntity> albumList = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      hasAll: _config.hasAll,
      onlyAll: _config.onlyAll,
      filterOption: _config.option,
    );

    _albumList.clear();

    for (var album in albumList) {
      _albumList[album] = await album.getAssetListPaged(page: 1, size: _config.countInPage);
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
