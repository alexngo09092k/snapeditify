import 'package:flutter/material.dart';
import 'package:snapedit/pages/all_photos/widgets/all_photos.dart';
import 'package:snapedit/pages/all_photos/widgets/try_suggested_images.dart';
import 'package:snapedit/widgets/app_layout.dart';

class AllPhotosPage extends StatelessWidget {
  const AllPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      back: true,
      screen: "All photos",
      children: [
        TrySuggestedImages(),
        AllPhotos(),
      ],
    );
  }
}
