import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_storage.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import '../data/layer.dart';
import 'colors_picker.dart';

class TextLayerOverlay extends StatefulWidget {
  final int index;
  final TextLayerData layer;
  final Function onUpdate;

  const TextLayerOverlay({
    super.key,
    required this.layer,
    required this.index,
    required this.onUpdate,
  });

  @override
  createState() => _TextLayerOverlayState();
}

class _TextLayerOverlayState extends State<TextLayerOverlay> {
  double slider = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
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
                width: 60,
                child: Text(
                  'Text Size',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
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
                        // print(v.toDouble());
                        widget.layer.size = v.toDouble();
                        widget.onUpdate();
                      });
                    }),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'Text Color',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return BarColorPicker(
                      width: constraints.maxWidth - AppDimensions.instance.paddingX(2),
                      thumbColor: Theme.of(context).colorScheme.primary,
                      initialColor: widget.layer.color,
                      cornerRadius: 10,
                      pickMode: PickMode.color,
                      colorListener: (int value) {
                        setState(() {
                          widget.layer.color = Color(value);
                          widget.onUpdate();
                        });
                      },
                    );
                  }
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.layer.color = Colors.black;
                    widget.onUpdate();
                  });
                },
                child:Text(
                  'Reset',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  'BG Color',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return BarColorPicker(
                      width: constraints.maxWidth - AppDimensions.instance.paddingX(2),
                      initialColor: widget.layer.background,
                      thumbColor: Theme.of(context).colorScheme.primary,
                      cornerRadius: 10,
                      pickMode: PickMode.color,
                      colorListener: (int value) {
                        setState(() {
                          widget.layer.background = Color(value);
                          widget.onUpdate();
                        });
                      },
                    );
                  }
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.layer.background = Colors.transparent;
                    widget.onUpdate();
                  });
                },
                child: Text(
                  'Reset',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  'BG Opacity',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: 255,
                  divisions: 255,
                  value: widget.layer.backgroundOpacity.toDouble(),
                  thumbColor: Colors.white,
                  onChanged: (double value) {
                    setState(() {
                      widget.layer.backgroundOpacity = value.toInt();
                      widget.onUpdate();
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.layer.backgroundOpacity = 0;
                    widget.onUpdate();
                  });
                },
                child: Text(
                  'Reset',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          CustomButton(
            title: "Remove",
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
