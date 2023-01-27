// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/camera_picker.dart';
import 'package:snapeditify/pages/photos/widgets/image_item.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';
import 'package:snapeditify/widgets/load_more/sliver_grid_load_more.dart';
import 'package:snapeditify/widgets/load_more/source_list.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key, this.album});
  final AssetPathEntity? album;

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends ProviderState<PhotosPage, GalleryProvider> {
  late final List<MultipleSliverSourceList<AssetEntity>> albums = [];

  @override
  void initState() {
    super.initState();
    UserPermission.instance.requestPermission(permission: [Permission.storage]);
  }

  onImage(Uint8List bytes) async {
    AppRoutes.instance.goEditImagePage(context, bytes: bytes);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Size(
      (AwesomeAppState.screen.width - AppDimensions.instance.gridDelegate.crossAxisSpacing * 2) / 3,
      (AwesomeAppState.screen.width - AppDimensions.instance.gridDelegate.crossAxisSpacing * 2) / 3,
    );
    return AppLayout(
      screen: widget.album != null ? widget.album!.name : 'Suggested',
      action: const CameraPicker(),
      children: [
        widget.album != null
            ? Expanded(
                child: SliverGridLoadMore<AssetEntity>(
                  sourceList: SourceList<AssetEntity>(
                    onLoadMore: (current, isloadMoreAction) => widget.album!.getAssetListPaged(
                      page: current.pageIndex,
                      size: provider.config.countInPage,
                    ),
                    onRefresh: (SourceList current) async {},
                  ),
                  gridDelegate: AppDimensions.instance.gridDelegate,
                  itemBuilder: (_, photo, ___) => ImageItem.withAssetEntity(photo, size: size, onImage: onImage),
                  indicatorBuilder: (_, status) {
                    switch (status) {
                      case IndicatorStatus.empty:
                        return IndicatorWidget(
                          status,
                          isSliver: true,
                          emptyWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LottieViewer(
                                lottie: AppAssets.instance.notFound,
                                width: AwesomeAppState.screen.width * 1 / 3,
                                height: AwesomeAppState.screen.width * 1 / 3,
                              ),
                              Text(
                                'Not found images',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).disabledColor),
                              )
                            ],
                          ),
                        );
                      default:
                    }
                    return null;
                  },
                ),
              )
            : BasePropConsumer<GalleryProvider, EditImageType>(
                listenable: provider,
                select: (_) => _.editImageType,
                builder: (_, __, p, ___) => Wrap(
                  spacing: AppDimensions.instance.gridDelegate.mainAxisSpacing,
                  runSpacing: AppDimensions.instance.gridDelegate.crossAxisSpacing,
                  children: p.suggestedPhotos.map((e) => ImageItem.withAsset(e, size: size, onImage: onImage)).toList(),
                ),
              ),
      ],
    );
  }
}
