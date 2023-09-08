import 'package:flutter/material.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_storage.dart';
import '../data/layer.dart';
import '../text_layer_overlay.dart';

/// Text layer
class TextLayer extends StatefulWidget {
  final TextLayerData layerData;
  final VoidCallback? onUpdate;

  const TextLayer({
    super.key,
    required this.layerData,
    this.onUpdate,
  });
  @override
  createState() => _TextViewState();
}

class _TextViewState extends State<TextLayer> {
  double initialSize = 0;
  double initialRotation = 0;

  @override
  Widget build(BuildContext context) {
    initialSize = widget.layerData.size;
    initialRotation = widget.layerData.rotation;

    return Positioned(
      left: widget.layerData.offset.dx,
      top: widget.layerData.offset.dy,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            context: context,
            builder: (context) {
              return TextLayerOverlay(
                index: ImageEditorStorage.instance.layers.indexOf(widget.layerData),
                layer: widget.layerData,
                onUpdate: () {
                  if (widget.onUpdate != null) widget.onUpdate!();
                  setState(() {});
                },
              );
            },
          );
        },
        onScaleUpdate: (detail) {
          if (detail.pointerCount == 1) {
            widget.layerData.offset = Offset(
              widget.layerData.offset.dx + detail.focalPointDelta.dx,
              widget.layerData.offset.dy + detail.focalPointDelta.dy,
            );
          } else if (detail.pointerCount == 2) {
            widget.layerData.size =
                initialSize + detail.scale * (detail.scale > 1 ? 1 : -1);

            // print('angle');
            // print(detail.rotation);
            widget.layerData.rotation = detail.rotation;
          }
          setState(() {});
        },
        child: Transform.rotate(
          angle: widget.layerData.rotation,
          child: Container(
            padding: const EdgeInsets.all(64),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.layerData.background
                    .withAlpha(widget.layerData.backgroundOpacity.toInt()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.layerData.text.toString(),
                textAlign: widget.layerData.align,
                style: TextStyle(
                  color: widget.layerData.color,
                  fontSize: widget.layerData.size,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
