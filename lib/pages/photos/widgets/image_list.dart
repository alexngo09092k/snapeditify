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
import 'package:snapeditify/widgets/base/custom_image.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key, required this.album});
  final AlbumVM album;

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends ProviderStateful<ImageList, IGalleryProvider> {
  List<AssetEntity>? _images;
  int _page = 0;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  @override
  void initState() {
    super.initState();
    _requestAssets();
  }

  Future<void> _requestAssets() async {
    final List<AssetEntity> entities =
        await widget.album.entityPath.getAssetListPaged(
      page: 0,
      size: provider.config.countInPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _images = entities;
      _hasMoreToLoad = _images!.length < widget.album.count;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities =
        await widget.album.entityPath.getAssetListPaged(
      page: _page + 1,
      size: provider.config.countInPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _images!.addAll(entities);
      _page++;
      _hasMoreToLoad = _images!.length < widget.album.count;
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pad = AppDimensions.instance.padding;

    if (_images == null || _images?.isNotEmpty != true) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(
                image: AppAssets.instance.notFoundImage,
                width: AwesomeAppState.screen.width * 1.5 / 3,
              ),
              Text(
                S.of(context).notFoundImages,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).disabledColor),
              )
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: GridView.custom(
        padding: EdgeInsets.fromLTRB(pad, pad * 0.5, pad, pad),
        gridDelegate: AppDimensions.instance.gridDelegate,
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext _, int index) {
            if (index == _images!.length - 8 &&
                !_isLoadingMore &&
                _hasMoreToLoad) {
              _loadMoreAsset();
            }
            final AssetEntity entity = _images![index];
            return ImageItem.withAssetEntity(
              entity,
              size: AppDimensions.instance.gridItemSize,
              onImage: (_) =>
                  AppRoutes.instance.goEditImagePage(context, bytes: _),
            );
          },
          childCount: _images!.length,
        ),
      ),
    );
  }
}
