// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/photos/widgets/image_list.dart';
import 'package:snapeditify/pages/photos/widgets/suggested_image_list.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/view_models/album_vm.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/camera_picker.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key, this.albumId});
  final String? albumId;

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends ProviderState<PhotosPage, GalleryProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.instance.pageBackground),
          fit: BoxFit.cover,
        ),
      ),
      center: BasePropConsumer<GalleryProvider, String?>(
        listenable: provider,
        builder: (_, __, ___, albumName) => Text(
          albumName ?? S.of(context).suggested,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
        ),
        select: (_) => _.albumList[widget.albumId]?.entityPath.name,
      ),
      action: const CameraPicker(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasePropConsumer<GalleryProvider, AlbumVM?>(
          listenable: provider,
          select: (_) => _.albumList[widget.albumId],
          builder: (_, __, ___, album) => album != null
              ? ImageList(
                  album: album,
                  provider: provider,
                )
              : const SuggestedImageList(),
        ),
      ],
    );
  }
}
