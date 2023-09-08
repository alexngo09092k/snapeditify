import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hand_signature/signature.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'data/image_item.dart';

class ImageEditorDrawing extends StatefulWidget {
  final ImageItem image;

  const ImageEditorDrawing({
    super.key,
    required this.image,
  });

  @override
  State<ImageEditorDrawing> createState() => _ImageEditorDrawingState();
}

class _ImageEditorDrawingState extends State<ImageEditorDrawing> {
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;

  final control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  List<CubicPath> undoList = [];
  bool skipNextEvent = false;

  List<Color> colorList = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.brown,
    Colors.indigo,
  ];

  void changeColor(Color color) {
    currentColor = color;
    setState(() {});
  }

  @override
  void initState() {
    control.addListener(() {
      if (control.hasActivePath) return;

      if (skipNextEvent) {
        skipNextEvent = false;
        return;
      }

      undoList = [];
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Container(
            padding: EdgeInsets.only(
              right: AppDimensions.instance.padding,
              left: AppDimensions.instance.padding,
            ),
            color: Colors.transparent,
            child: const CustomIcon(Icons.clear),
          ),
        ),
        actions: [
          FeatureButton(
            icon: Icons.undo,
            color: control.paths.isNotEmpty
                ? Colors.white
                : Colors.white.withAlpha(80),
            onTap: () {
              if (control.paths.isEmpty) return;
              skipNextEvent = true;
              undoList.add(control.paths.last);
              control.stepBack();
              setState(() {});
            },
          ),
          FeatureButton(
            icon: Icons.redo,
            color:
                undoList.isNotEmpty ? Colors.white : Colors.white.withAlpha(80),
            onTap: () {
              if (undoList.isEmpty) return;

              control.paths.add(undoList.removeLast());
              setState(() {});
            },
          ),
          FeatureButton(
            icon: Icons.check,
            onTap: () async {
              if (control.paths.isEmpty) return Navigator.pop(context);

              var data = await control.toImage(
                color: currentColor,
                height: widget.image.height,
                width: widget.image.width,
              );

              if (!mounted) return;

              return Navigator.pop(context, data!.buffer.asUint8List());
            },
          ),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            BaseImageEditor(builder: (width, height) {
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.memory(widget.image.image).image,
                    fit: BoxFit.contain,
                  ),
                ),
                child: HandSignature(
                  control: control,
                  color: currentColor,
                  width: 1.0,
                  maxWidth: 10.0,
                  type: SignatureDrawType.shape,
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70 + MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.rectangle,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ColorButton(
              color: Colors.yellow,
              onTap: (color) {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.black87,
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: HueRingPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            for (int i = 0; i < colorList.length; i++)
              ColorButton(
                color: colorList[i],
                onTap: (color) => changeColor(color),
                isSelected: colorList[i] == currentColor,
              ),
          ],
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final Function onTap;
  final bool isSelected;

  const ColorButton({
    super.key,
    required this.color,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: Container(
        height: 34,
        width: 34,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white54,
            width: isSelected ? 3 : 1,
          ),
        ),
      ),
    );
  }
}
