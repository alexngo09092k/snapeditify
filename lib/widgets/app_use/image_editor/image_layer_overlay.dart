import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_storage.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import 'data/layer.dart';

class ImageLayerOverlay extends StatefulWidget {
  final int index;
  final ImageLayerData layerData;
  final Function onUpdate;

  const ImageLayerOverlay({
    super.key,
    required this.layerData,
    required this.index,
    required this.onUpdate,
  });

  @override
  createState() => _ImageLayerOverlayState();
}

class _ImageLayerOverlayState extends State<ImageLayerOverlay> {
  double slider = 0.0;

  @override
  void initState() {
    //  slider = widget.sizevalue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppDimensions.instance.radius),
          topLeft: Radius.circular(AppDimensions.instance.radius),
        ),
      ),
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  S.of(context).size,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Slider(
                    value: widget.layerData.scale,
                    min: 0,
                    max: 2,
                    divisions: 100,
                    onChangeEnd: (v) {
                      setState(() {
                        widget.layerData.scale = v.toDouble();
                        widget.onUpdate();
                      });
                    },
                    onChanged: (v) {
                      setState(() {
                        slider = v;
                        // print(v.toDouble());
                        widget.layerData.scale = v.toDouble();
                        widget.onUpdate();
                      });
                    }),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          CustomButton(
            title: S.of(context).remove,
            height: 45,
            onTap: () {
              ImageEditorStorage.instance.removedLayers.add(ImageEditorStorage.instance.layers.removeAt(widget.index));
              Navigator.pop(context);
              widget.onUpdate();
            },
          ),
        ],
      ),
    );
  }
}
