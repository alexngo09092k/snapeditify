import 'package:flutter/material.dart';
import 'package:phosart/pages/save/widgets/saved_image.dart';
import 'package:phosart/pages/save/widgets/saved_image_open.dart';
import 'package:phosart/pages/save/widgets/saved_image_share.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';
import 'package:phosart/widgets/base/app_layout.dart';

class SavePage extends StatelessWidget {
  const SavePage({super.key, required this.type});
  final EditImageType type;

  @override
  Widget build(BuildContext context) {
    final provider = type.provider;
    return AppLayout(
      action: Row(
        children: const [
          SavedImageShare(),
          SavedImageOpen(),
        ],
      ),
      children: [
        SavedImage(provider: provider),
      ],
    );
  }
}
