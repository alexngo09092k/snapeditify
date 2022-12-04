import 'package:flutter/material.dart';
import 'package:snapedit/pages/photo_gallery/widgets/try_suggested_images.dart';
import 'package:snapedit/widgets/app_layout.dart';

class PhotoGalleryPage extends StatelessWidget {
  const PhotoGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      back: true,
      screen: "All photos",
      scroll: false,
      children: [
        TrySuggestedImages(),
      ],
    );
  }
}
