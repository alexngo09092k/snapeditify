import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_storage.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import '../data/layer.dart';

class EmojiLayerOverlay extends StatefulWidget {
  final int index;
  final EmojiLayerData layer;
  final Function onUpdate;

  const EmojiLayerOverlay({
    super.key,
    required this.layer,
    required this.index,
    required this.onUpdate,
  });

  @override
  createState() => _EmojiLayerOverlayState();
}

class _EmojiLayerOverlayState extends State<EmojiLayerOverlay> {
  double slider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.instance.radius),
          topLeft: Radius.circular(AppDimensions.instance.radius),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  'Sizet',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: Slider(
                  value: widget.layer.size,
                  min: 0.0,
                  max: 100.0,
                  onChangeEnd: (v) {
                    setState(() {
                      widget.layer.size = v.toDouble();
                      widget.onUpdate();
                    });
                  },
                  onChanged: (v) {
                    setState(() {
                      slider = v;
                      widget.layer.size = v.toDouble();
                      widget.onUpdate();
                    });
                  },
                ),
              ),
            ],
          ),
          CustomButton(
            onTap: () {
              ImageEditorStorage.instance.removedLayers.add(
                  ImageEditorStorage.instance.layers.removeAt(widget.index));
              Navigator.pop(context);
              widget.onUpdate();
            },
            height: 45,
            title: 'Remove',
          ),
        ],
      ),
    );
  }
}
