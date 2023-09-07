
import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/image_editor.dart' as image_editor;
import 'utils.dart';

/// Crop given image with various aspect ratios
class ImageCropper extends StatefulWidget {
  final Uint8List image;
  final List<AspectRatioOption> availableRatios;

  const ImageCropper({
    super.key,
    required this.image,
    this.availableRatios = const [
      AspectRatioOption(title: 'Freeform'),
      AspectRatioOption(title: '1:1', ratio: 1),
      AspectRatioOption(title: '4:3', ratio: 4 / 3),
      AspectRatioOption(title: '5:4', ratio: 5 / 4),
      AspectRatioOption(title: '7:5', ratio: 7 / 5),
      AspectRatioOption(title: '16:9', ratio: 16 / 9),
    ],
  });

  @override
  createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  final GlobalKey<ExtendedImageEditorState> _controller =
      GlobalKey<ExtendedImageEditorState>();

  double? aspectRatio;
  double? aspectRatioOriginal;
  bool isLandscape = true;
  int rotateAngle = 0;

  @override
  void initState() {
    if (widget.availableRatios.isNotEmpty) {
      aspectRatio = aspectRatioOriginal = widget.availableRatios.first.ratio;
    }
    _controller.currentState?.rotate(right: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.currentState != null) {
      // _controller.currentState?.
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            icon: const Icon(Icons.check),
            onPressed: () async {
              var state = _controller.currentState;

              if (state == null) return;

              var data = await cropImageDataWithNativeLibrary(state: state);

              if (mounted) Navigator.pop(context, data);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: ExtendedImage.memory(
          widget.image,
          cacheRawData: true,
          fit: BoxFit.contain,
          extendedImageEditorKey: _controller,
          mode: ExtendedImageMode.editor,
          initEditorConfigHandler: (state) {
            return EditorConfig(
              cropAspectRatio: aspectRatio,
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 80,
          child: Column(
            children: [
              // Container(
              //   height: 48,
              //   decoration: const BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //         color: black,
              //         blurRadius: 10,
              //       ),
              //     ],
              //   ),
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: <Widget>[
              //       IconButton(
              //         icon: Icon(
              //           Icons.portrait,
              //           color: isLandscape ? gray : white,
              //         ).paddingSymmetric(horizontal: 8, vertical: 4),
              //         onPressed: () {
              //           isLandscape = false;
              //           if (aspectRatioOriginal != null) {
              //             aspectRatio = 1 / aspectRatioOriginal!;
              //           }
              //           setState(() {});
              //         },
              //       ),
              //       IconButton(
              //         icon: Icon(
              //           Icons.landscape,
              //           color: isLandscape ? white : gray,
              //         ).paddingSymmetric(horizontal: 8, vertical: 4),
              //         onPressed: () {
              //           isLandscape = true;
              //           aspectRatio = aspectRatioOriginal!;
              //           setState(() {});
              //         },
              //       ),
              //       Slider(
              //         activeColor: Colors.white,
              //         inactiveColor: Colors.grey,
              //         value: rotateAngle.toDouble(),
              //         min: 0.0,
              //         max: 100.0,
              //         onChangeEnd: (v) {
              //           rotateAngle = v.toInt();
              //           setState(() {});
              //         },
              //         onChanged: (v) {
              //           rotateAngle = v.toInt();
              //           setState(() {});
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (aspectRatioOriginal != null &&
                          aspectRatioOriginal != 1)
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          icon: Icon(
                            Icons.portrait,
                            color: isLandscape ? Colors.grey : Colors.white,
                          ),
                          onPressed: () {
                            isLandscape = false;
                            if (aspectRatioOriginal != null) {
                              aspectRatio = 1 / aspectRatioOriginal!;
                            }
                            setState(() {});
                          },
                        ),
                      if (aspectRatioOriginal != null &&
                          aspectRatioOriginal != 1)
                        IconButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          icon: Icon(
                            Icons.landscape,
                            color: isLandscape ? Colors.white : Colors.grey,
                          ),
                          onPressed: () {
                            isLandscape = true;
                            aspectRatio = aspectRatioOriginal!;
                            setState(() {});
                          },
                        ),
                      for (var ratio in widget.availableRatios)
                        imageRatioButton(ratio.ratio, ratio.title),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> cropImageDataWithNativeLibrary(
      {required ExtendedImageEditorState state}) async {
    final Rect? cropRect = state.getCropRect();
    final EditActionDetails action = state.editAction!;

    final int rotateAngle = action.rotateAngle.toInt();
    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    final Uint8List img = state.rawImageData;

    final option = image_editor.ImageEditorOption();

    if (action.needCrop) {
      option.addOption(image_editor.ClipOption.fromRect(cropRect!));
    }

    if (action.needFlip) {
      option.addOption(image_editor.FlipOption(
          horizontal: flipHorizontal, vertical: flipVertical));
    }

    if (action.hasRotateAngle) {
      option.addOption(image_editor.RotateOption(rotateAngle));
    }

    // final DateTime start = DateTime.now();
    final Uint8List? result = await image_editor.ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    // print('${DateTime.now().difference(start)} ：total time');

    return result;
  }

  Widget imageRatioButton(double? ratio, String title) {
    return TextButton(
      onPressed: () {
        aspectRatioOriginal = ratio;

        if (aspectRatioOriginal != null && isLandscape == false) {
          aspectRatio = 1 / aspectRatioOriginal!;
        } else {
          aspectRatio = aspectRatioOriginal;
        }

        setState(() {});
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: TextStyle(
              color: aspectRatioOriginal == ratio ? Colors.white : Colors.grey,
            ),
          )),
    );
  }
}
