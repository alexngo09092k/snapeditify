import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/pages/gallery/widgets/album_photo.dart';
import 'package:snapedit/pages/gallery/widgets/album_title.dart';
import 'package:snapedit/pages/gallery/widgets/try_suggested_images.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';
import 'package:snapedit/widgets/app_layout.dart';
import 'package:snapedit/widgets/base/load_more/multiple_sliver_load_more.dart';
import 'package:snapedit/widgets/base/load_more/source_list.dart';

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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  onPhoto(String? photo, ImageSource type) async {
    if (photo != null) {
      AppRoutes.instance.goEditPhotoPage(context, type: type, photo: photo);
    }
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
        child: TrySuggestedImages(gridDelegate: gridDelegate, size: size, onPhoto: onPhoto),
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
              itemBuilder: (_, photo, ___) => AlbumPhoto.withAssetEntity(photo, size: size, onPhoto: onPhoto),
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
