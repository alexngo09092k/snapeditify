import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_provider.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor.dart';
import 'package:snapeditify/widgets/app_use/image_editor/utils.dart';

class FastEditor extends StatelessWidget {
  const FastEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return PropConsumer<FastEditorProvider, Uint8List>(
      select: (_) => _.state.image.imageBytes,
      builder: (_, __, ___, imageData) {
        return ImageEditor(
          image: imageData,
          features: const ImageEditorFeatures(
            crop: true,
            blur: true,
            brush: true,
            emoji: true,
            filters: true,
            flip: true,
            rotate: true,
            text: true,
          ),
        );
      },
    );
  }
}
