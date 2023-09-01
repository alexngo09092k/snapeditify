import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_provider.dart';
import 'package:snapeditify/widgets/app_use/app_layout.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor.dart';

class FastEditor extends StatelessWidget {
  const FastEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      children: [
        PropConsumer<FastEditorProvider, Uint8List>(
          select: (_) => _.state.image.imageBytes,
          builder: (_, __, ___, imageData) {
            return Expanded(
              child: ImageEditor(
                image: imageData,
              ),
            );
          },
        )
      ],
    );
  }
}
