import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hand_signature/signature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/buttons.dart';
import 'data/image_item.dart';

/// Show image drawing surface over image
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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            icon: const Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            icon: Icon(
              Icons.undo,
              color: control.paths.isNotEmpty
                  ? Colors.white
                  : Colors.white.withAlpha(80),
            ),
            onPressed: () {
              if (control.paths.isEmpty) return;
              skipNextEvent = true;
              undoList.add(control.paths.last);
              control.stepBack();
              setState(() {});
            },
          ),
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            icon: Icon(
              Icons.redo,
              color: undoList.isNotEmpty
                  ? Colors.white
                  : Colors.white.withAlpha(80),
            ),
            onPressed: () {
              if (undoList.isEmpty) return;

              control.paths.add(undoList.removeLast());
              setState(() {});
            },
          ),
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            icon: const Icon(Icons.check),
            onPressed: () async {
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
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 2),
            ],
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
      ),
    );
  }
}
