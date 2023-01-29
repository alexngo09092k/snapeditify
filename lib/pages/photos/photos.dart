// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/photos/widgets/image_list.dart';
import 'package:snapeditify/pages/photos/widgets/suggested_image_list.dart';
import 'package:snapeditify/view_models/album_vm.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/camera_picker.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({super.key, this.album});
  final AlbumVM? album;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: album != null ? album!.entityPath.name : S.of(context).suggested,
      action: const CameraPicker(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        album != null ? ImageList(album: album!) : const SuggestedImageList(),
      ],
    );
  }
}
