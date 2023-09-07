import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_provider.dart';
import 'package:snapeditify/widgets/app_use/image_editor/data/editor_feature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor.dart';

class FastEditor extends StatefulWidget {
  const FastEditor({super.key});

  @override
  State<FastEditor> createState() => _FastEditorState();
}

class _FastEditorState extends ProviderStateful<FastEditor, IFastEditorProvider> {
  
  void _onSave(Uint8List? imageBytes) {
    provider.save(context, imageBytes: imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return PropConsumer<FastEditorProvider, Uint8List>(
      select: (_) => _.state.image.imageBytes,
      builder: (_, __, ___, imageData) {
        return ImageEditor(
          image: imageData,
          features: const [
            EditorFeature.crop,
            EditorFeature.blur,
            EditorFeature.brush,
            EditorFeature.text,
            EditorFeature.flip,
            EditorFeature.rotate,
            EditorFeature.filters,
            EditorFeature.emoji,
          ],
          onSave: _onSave,
        );
      },
    );
  }
}
