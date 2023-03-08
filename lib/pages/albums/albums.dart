// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/albums/widgets/album_list.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/camera_picker.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: S.of(context).albums,
      action: const CameraPicker(),
      children: const [AlbumList()],
    );
  }
}
