import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/image_editor.dart' as image_editor;
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'utils.dart';

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
        elevation: 0,
        actions: [
          FeatureButton(
            icon: Icons.check,
            onTap: () async {
              ExtendedImageEditorState? state = _controller.currentState;
              if (state == null) return;
              Uint8List? data =
                  await cropImageDataWithNativeLibrary(state: state);
              if (mounted) Navigator.pop(context, data);
            },
          ),
          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            BaseImageEditor(builder: (_, __) {
              return ExtendedImage.memory(
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
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60 + MediaQuery.of(context).padding.bottom,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.rectangle,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            if (aspectRatioOriginal != null && aspectRatioOriginal != 1)
              FeatureButton(
                icon: Icons.portrait,
                color: isLandscape
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).primaryColor,
                onTap: () {
                  isLandscape = false;
                  if (aspectRatioOriginal != null) {
                    aspectRatio = 1 / aspectRatioOriginal!;
                  }
                  setState(() {});
                },
              ),
            if (aspectRatioOriginal != null && aspectRatioOriginal != 1)
              FeatureButton(
                icon: Icons.landscape,
                color: isLandscape
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).primaryColor,
                onTap: () {
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
        horizontal: flipHorizontal,
        vertical: flipVertical,
      ));
    }

    if (action.hasRotateAngle) {
      option.addOption(image_editor.RotateOption(rotateAngle));
    }

    final Uint8List? result = await image_editor.ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

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
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.instance.paddingX(0.5),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: aspectRatioOriginal == ratio
                    ? Theme.of(context).primaryColor
                    : null,
              ),
        ),
      ),
    );
  }
}
