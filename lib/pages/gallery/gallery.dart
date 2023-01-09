// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:phosart/common/app_routes.dart';
import 'package:phosart/pages/gallery/widgets/album_image.dart';
import 'package:phosart/pages/gallery/widgets/album_title.dart';
import 'package:phosart/pages/gallery/widgets/try_suggested_images.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';
import 'package:phosart/widgets/app_layout.dart';
import 'package:phosart/widgets/base/load_more/multiple_sliver_load_more.dart';
import 'package:phosart/widgets/base/load_more/source_list.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends ProviderState<GalleryPage, GalleryProvider> {
  late final List<MultipleSliverSourceList<AssetEntity>> albums = [];

  @override
  void initState() {
    super.initState();
    UserPermission.instance.requestPermission(permission: [Permission.storage]);
    initial().then((value) => setState(() {}));
  }

  onImage(Uint8List bytes, ImageSource type) async {
    AppRoutes.instance.goEditImagePage(context, type: type, bytes: bytes);
  }

  Future<void> initial() async {
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 3.0,
      mainAxisSpacing: 3.0,
    );
    final Size size = Size(
      (AwesomeAppState.screen.width - gridDelegate.crossAxisSpacing * 2) / 3,
      (AwesomeAppState.screen.width - gridDelegate.crossAxisSpacing * 2) / 3,
    );

    albums.add(MultipleSliverSourceList<AssetEntity>(
      headerBuilder: (_, __) => SliverToBoxAdapter(
        key: const ValueKey("try_suggested_images"),
        child: TrySuggestedImages(gridDelegate: gridDelegate, size: size, onImage: onImage),
      ),
    ));
    albums.addAll(
      provider.albumList.keys.where((e) => (provider.albumList[e] ?? 0) > 0).map(
            (e) => MultipleSliverSourceList<AssetEntity>(
              sourceList: SourceList<AssetEntity>(
                maxLength: provider.albumList[e] ?? 0,
                onLoadMore: (current, isloadMoreAction) => e.getAssetListPaged(
                  page: current.pageIndex,
                  size: provider.config.countInPage,
                ),
                onRefresh: (SourceList current) async {},
              ),
              itemBuilder: (_, photo, ___) => AlbumImage.withAssetEntity(photo, size: size, onImage: onImage),
              headerBuilder: (_, __) => SliverToBoxAdapter(
                key: ValueKey("${e.name}_title"),
                child: AlbumTitle(album: e, total: provider.albumList[e] ?? 0),
              ),
              gridDelegate: gridDelegate,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      back: true,
      scroll: false,
      screen: "Gallery",
      children: [
        Expanded(
          child: MultipleSliverLoadMore(
            list: [
              ...albums,
            ],
          ),
        )
      ],
    );
  }
}
