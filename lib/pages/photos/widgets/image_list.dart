// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/photos/widgets/image_item.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/view_models/album_vm.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key, required this.album});
  final AlbumVM album;

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends ProviderStateObserver<ImageList, GalleryProvider> {
  List<AssetEntity>? _images;
  int _page = 0;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  AlbumVM get album => provider.albumList[widget.album.entityPath.id]!;

  @override
  void initState() {
    super.initState();
    _requestAssets();
    provider.galleryChanged.listen((_) => _requestAssets());
  }

  Future<void> _requestAssets() async {
    final List<AssetEntity> entities = await album.entityPath.getAssetListPaged(
      page: 0,
      size: provider.config.countInPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _images = entities;
      _hasMoreToLoad = _images!.length < album.count;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await album.entityPath.getAssetListPaged(
      page: _page + 1,
      size: provider.config.countInPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _images!.addAll(entities);
      _page++;
      _hasMoreToLoad = _images!.length < album.count;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_images?.isNotEmpty != true) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieViewer(
                lottie: AppAssets.instance.notFound,
                width: AwesomeAppState.screen.width * 1 / 3,
                height: AwesomeAppState.screen.width * 1 / 3,
              ),
              Text(
                S.of(context).notFoundImages,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).disabledColor),
              )
            ],
          ),
        ),
      );
    }
    return Expanded(
      child: GridView.custom(
        gridDelegate: AppDimensions.instance.gridDelegate,
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext _, int index) {
            if (index == _images!.length - 8 && !_isLoadingMore && _hasMoreToLoad) {
              _loadMoreAsset();
            }
            final AssetEntity entity = _images![index];
            return ImageItem.withAssetEntity(
              entity,
              size: AppDimensions.instance.gridItemSize,
              onImage: (_) => AppRoutes.instance.goEditImagePage(context, bytes: _),
            );
          },
          childCount: _images!.length,
        ),
      ),
    );
  }
}
