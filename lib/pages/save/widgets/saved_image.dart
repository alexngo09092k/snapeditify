import 'package:flutter/material.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/widgets/base/base_image_editor.dart';
import 'package:phosart/widgets/painter/painter_pure.dart';

class SavedImage extends StatefulWidget {
  const SavedImage({super.key, required this.provider});
  final EditImageProvider provider;

  @override
  State<SavedImage> createState() => _SavedImageState();
}

class _SavedImageState extends State<SavedImage> {
  late PainterController _controller;

  @override
  void initState() {
    _controller = PainterController();
    _controller.background = widget.provider.imageUI.backgroundDrawable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => Center(
        child: AspectRatio(
          aspectRatio: (widget.provider.imageUI.width / widget.provider.imageUI.height),
          child: FlutterPainter(controller: _controller),
        ),
      ),
    );
  }
}
