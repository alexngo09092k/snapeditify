// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/pages/albums/widgets/album_list.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_layout.dart';
import 'package:snapeditify/widgets/base/camera_picker.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends ProviderState<AlbumsPage, GalleryProvider> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: 'Albums',
      action: const CameraPicker(),
      children: [
        AlbumList(provider: provider),
      ],
    );
  }
}
