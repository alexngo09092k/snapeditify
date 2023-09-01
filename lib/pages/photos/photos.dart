// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/photos/widgets/image_list.dart';
import 'package:snapeditify/pages/photos/widgets/suggest_image_list.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/view_models/album_vm.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/camera_picker.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({super.key, this.albumId});
  final String? albumId;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      center: PropConsumer<IGalleryProvider, String?>(
        builder: (_, __, ___, albumName) => Text(
          albumName ?? S.of(context).suggested,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
        ),
        select: (_) => _.albumList[albumId]?.entityPath.name,
      ),
      action: const CameraPicker(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropConsumer<GalleryProvider, AlbumVM?>(
          select: (_) => _.albumList[albumId],
          builder: (_, __, ___, album) => album != null ? ImageList(album: album): const SuggestedImageList(),
        ),
      ],
    );
  }
}
