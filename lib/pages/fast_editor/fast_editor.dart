import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_provider.dart';
import 'package:snapeditify/widgets/app_use/image_editor/data/editor_feature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor.dart';

class FastEditor extends StatelessWidget {
  const FastEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return PropConsumer<FastEditorProvider, Uint8List>(
      select: (_) => _.state.image.imageBytes,
      builder: (_, __, ___, imageData) {
        return ImageEditor(image: imageData, features: const [
          EditorFeature.crop,
          EditorFeature.blur,
          EditorFeature.brush,
          EditorFeature.text,
          EditorFeature.flip,
          EditorFeature.rotate,
          EditorFeature.filters,
          EditorFeature.emoji,
        ]);
      },
    );
  }
}
