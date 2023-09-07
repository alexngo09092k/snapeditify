import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/image_editor/data/editor_feature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_color_filter.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_cropper.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_drawing.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_storage.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_filters.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'data/image_item.dart';
import 'data/layer.dart';
import 'layers/background_blur_layer.dart';
import 'layers/background_layer.dart';
import 'layers/emoji_layer.dart';
import 'layers/image_layer.dart';
import 'layers/text_layer.dart';
import 'modules/all_emojies.dart';
import 'modules/text.dart';
import 'utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class SingleImageEditor extends StatefulWidget {
  final dynamic image;
  final List? imageList;
  final List<EditorFeature> features;
  final List<AspectRatioOption> cropAvailableRatios;
  final Function(Uint8List?)? onSave;

  const SingleImageEditor({
    super.key,
    this.image,
    this.imageList,
    this.features = EditorFeature.values,
    this.cropAvailableRatios = const [
      AspectRatioOption(title: 'Freeform'),
      AspectRatioOption(title: '1:1', ratio: 1),
      AspectRatioOption(title: '4:3', ratio: 4 / 3),
      AspectRatioOption(title: '5:4', ratio: 5 / 4),
      AspectRatioOption(title: '7:5', ratio: 7 / 5),
      AspectRatioOption(title: '16:9', ratio: 16 / 9),
    ],
    this.onSave,
  });

  @override
  createState() => _SingleImageEditorState();
}

class _SingleImageEditorState extends State<SingleImageEditor> {
  ImageItem currentImage = ImageItem();

  Offset offset1 = Offset.zero;
  Offset offset2 = Offset.zero;

  final GlobalKey container = GlobalKey();
  final GlobalKey globalKey = GlobalKey();

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    if (widget.image != null) {
      loadImage(widget.image!);
    }

    super.initState();
  }

  @override
  void dispose() {
    ImageEditorStorage.instance.layers.clear();
    super.dispose();
  }

  void undo() {
    if (ImageEditorStorage.instance.layers.isEmpty) return;

    if (ImageEditorStorage.instance.removedLayers.isNotEmpty) {
      ImageEditorStorage.instance.layers
          .add(ImageEditorStorage.instance.removedLayers.removeLast());
      setState(() {});
      return;
    }

    ImageEditorStorage.instance.undoLayers
        .add(ImageEditorStorage.instance.layers.removeLast());

    setState(() {});
  }

  void redo() {
    if (ImageEditorStorage.instance.undoLayers.isEmpty) return;

    ImageEditorStorage.instance.layers
        .add(ImageEditorStorage.instance.undoLayers.removeLast());

    setState(() {});
  }

  Future<void> onPhoto() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    loadImage(image);
  }

  Future<void> onCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    loadImage(image);
  }

  Future<void> onSave() async {
    resetTransformation();
    setState(() {});

    Uint8List? binaryIntList = await screenshotController.capture(pixelRatio: pixelRatio);

    if(widget.onSave != null) widget.onSave!(binaryIntList);
  }

  final picker = ImagePicker();

  Future<void> loadImage(dynamic imageFile) async {
    await currentImage.load(imageFile);

    ImageEditorStorage.instance.layers.clear();

    ImageEditorStorage.instance.layers
        .add(BackgroundLayerData(file: currentImage));

    setState(() {});
  }

  double flipValue = 0;
  int rotateValue = 0;

  double x = 0;
  double y = 0;
  double z = 0;

  double lastScaleFactor = 1, scaleFactor = 1;
  double widthRatio = 1, heightRatio = 1, pixelRatio = 1;

  resetTransformation() {
    scaleFactor = 1;
    x = 0;
    y = 0;
    setState(() {});
  }

  /// obtain image Uint8List by merging layers
  Future<Uint8List?> getMergedImage() async {
    if (ImageEditorStorage.instance.layers.length == 1 &&
        ImageEditorStorage.instance.layers.first is BackgroundLayerData) {
      return (ImageEditorStorage.instance.layers.first as BackgroundLayerData)
          .file
          .image;
    } else if (ImageEditorStorage.instance.layers.length == 1 &&
        ImageEditorStorage.instance.layers.first is ImageLayerData) {
      return (ImageEditorStorage.instance.layers.first as ImageLayerData)
          .image
          .image;
    }

    return screenshotController.capture(pixelRatio: pixelRatio);
  }

  Future<void> crop() async {
    resetTransformation();
    var mergedImage = await getMergedImage();
    if (!mounted) return;
    Uint8List? croppedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageCropper(
          image: mergedImage!,
          availableRatios: widget.cropAvailableRatios,
        ),
      ),
    );
    if (croppedImage == null) return;
    flipValue = 0;
    rotateValue = 0;

    await currentImage.load(croppedImage);
    setState(() {});
  }

  Future<void> brush() async {
    var drawing = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageEditorDrawing(image: currentImage)),
    );

    if (drawing != null) {
      ImageEditorStorage.instance.undoLayers.clear();
      ImageEditorStorage.instance.removedLayers.clear();

      ImageEditorStorage.instance.layers.add(
        ImageLayerData(
          image: ImageItem(drawing),
          offset: Offset(
            -currentImage.width / 4,
            -currentImage.height / 4,
          ),
        ),
      );

      setState(() {});
    }
  }

  Future<void> addText() async {
    TextLayerData? layer = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TextEditorImage()),
    );

    if (layer == null) return;

    ImageEditorStorage.instance.undoLayers.clear();
    ImageEditorStorage.instance.removedLayers.clear();
    ImageEditorStorage.instance.layers.add(layer);

    setState(() {});
  }

  Future<void> flip() async {
    setState(() {
      flipValue = flipValue == 0 ? math.pi : 0;
    });
  }

  Future<void> rotateLeft() async {
    var t = currentImage.width;
    currentImage.width = currentImage.height;
    currentImage.height = t;

    rotateValue--;
    setState(() {});
  }

  Future<void> rotateRight() async {
    var t = currentImage.width;
    currentImage.width = currentImage.height;
    currentImage.height = t;

    rotateValue++;
    setState(() {});
  }

  Future<void> blur() async {
    List<BackgroundBlurLayerData> oldlist = ImageEditorStorage.instance.layers.whereType<BackgroundBlurLayerData>().toList();
    BackgroundBlurLayerData blurLayer = oldlist.isNotEmpty ? 
    oldlist.last
    : BackgroundBlurLayerData(
      color: Colors.transparent,
      radius: 0.0,
      opacity: 0.0,
    );

    ImageEditorStorage.instance.undoLayers.clear();
    ImageEditorStorage.instance.removedLayers.clear();
    if(oldlist.isNotEmpty) {
      ImageEditorStorage.instance.layers = ImageEditorStorage.instance.layers.map((e) {
        if(e is BackgroundBlurLayerData) {
          return blurLayer;
        }
        return e;
      }).toList();
    }else {
      ImageEditorStorage.instance.layers.add(blurLayer);
    }
    setState(() {});

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (context) {
        return ImageColorFilter(
          radius: blurLayer.radius,
          opacity: blurLayer.opacity,
          color: blurLayer.color,
          onChangeColor: (_) => setState(() {
            blurLayer.color = _;
          }),
          onChangeRadius: (_) => setState(() {
            blurLayer.radius = _;
          }),
          onChangeOpacity: (_) => setState(() {
            blurLayer.opacity = _;
          }),
          onResetColor: () => setState(() {
            blurLayer.color = Colors.transparent;
          }),
          onResetOpacity: () => setState(() {
            blurLayer.opacity = 0;
          }),
          onResetRadius: () => setState(() {
            blurLayer.radius = 0;
          }),
        );
      },
    );
  }

  Future<void> filter() async {
    resetTransformation();

    var mergedImage = await getMergedImage();

    if (!mounted) return;

    Uint8List? filterAppliedImage = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ImageFilters(image: mergedImage!)),
    );

    if (filterAppliedImage == null) return;

    ImageEditorStorage.instance.removedLayers.clear();
    ImageEditorStorage.instance.undoLayers.clear();

    var layer = BackgroundLayerData(
      file: ImageItem(filterAppliedImage),
    );

    ImageEditorStorage.instance.layers.add(layer);

    await layer.file.status;

    setState(() {});
  }

  Future<void> emoji() async {
    EmojiLayerData? layer = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return const Emojies();
      },
    );

    if (layer == null) return;

    ImageEditorStorage.instance.undoLayers.clear();
    ImageEditorStorage.instance.removedLayers.clear();
    ImageEditorStorage.instance.layers.add(layer);

    setState(() {});
  }

  void canBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageEditorStorage.instance.viewportSize = MediaQuery.of(context).size;
    Widget layersStack = Stack(
      children: ImageEditorStorage.instance.layers.map((layerItem) {
        // Background layer
        if (layerItem is BackgroundLayerData) {
          return BackgroundLayer(
            layerData: layerItem,
            onUpdate: () {
              setState(() {});
            },
          );
        }

        // Image layer
        if (layerItem is ImageLayerData) {
          return ImageLayer(
            layerData: layerItem,
            onUpdate: () {
              setState(() {});
            },
          );
        }

        // Background blur layer
        if (layerItem is BackgroundBlurLayerData && layerItem.radius > 0) {
          return BackgroundBlurLayer(
            layerData: layerItem,
            onUpdate: () {
              setState(() {});
            },
          );
        }

        // Emoji layer
        if (layerItem is EmojiLayerData) {
          return EmojiLayer(
            layerData: layerItem,
            onUpdate: () {
              setState(() {});
            },
          );
        }

        // Text layer
        if (layerItem is TextLayerData) {
          return TextLayer(
            layerData: layerItem,
            onUpdate: () {
              setState(() {});
            },
          );
        }

        // Blank layer
        return Container();
      }).toList(),
    );

    widthRatio =
        currentImage.width / ImageEditorStorage.instance.viewportSize.width;
    heightRatio =
        currentImage.height / ImageEditorStorage.instance.viewportSize.height;
    pixelRatio = math.max(heightRatio, widthRatio);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => canBack(context),
          child: Container(
            padding: EdgeInsets.only(
              right: AppDimensions.instance.padding,
              left: AppDimensions.instance.padding,
            ),
            color: Colors.transparent,
            child: const CustomIcon(CupertinoIcons.back),
          ),
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 48,
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                FeatureButton(
                  icon: Icons.undo,
                  color: ImageEditorStorage.instance.layers.length > 1 ||
                          ImageEditorStorage.instance.removedLayers.isNotEmpty
                      ? Colors.white
                      : Colors.grey,
                  onTap: undo,
                ),
                FeatureButton(
                  icon: Icons.redo,
                  color: ImageEditorStorage.instance.undoLayers.isNotEmpty
                      ? Colors.white
                      : Colors.grey,
                  onTap: redo,
                ),
                if (widget.features.contains(EditorFeature.pickFromGallery))
                  FeatureButton(
                    icon: Icons.photo,
                    onTap: onPhoto,
                  ),
                if (widget.features.contains(EditorFeature.captureFromCamera))
                  FeatureButton(
                    icon: Icons.camera_alt,
                    onTap: onCamera,
                  ),
                FeatureButton(
                  icon: Icons.check,
                  onTap: onSave,
                ),
              ]),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            BaseImageEditor(
              builder: (_, __) => Stack(
                children: [
                  GestureDetector(
                    onScaleUpdate: (details) {
                      // move
                      if (details.pointerCount == 1) {
                        x += details.focalPointDelta.dx;
                        y += details.focalPointDelta.dy;
                        setState(() {});
                      }

                      // scale
                      if (details.pointerCount == 2) {
                        if (details.horizontalScale != 1) {
                          scaleFactor = lastScaleFactor *
                              math.min(details.horizontalScale,
                                  details.verticalScale);
                          setState(() {});
                        }
                      }
                    },
                    onScaleEnd: (details) {
                      lastScaleFactor = scaleFactor;
                    },
                    child: Center(
                      child: SizedBox(
                        height: currentImage.height / pixelRatio,
                        width: currentImage.width / pixelRatio,
                        child: Screenshot(
                          controller: screenshotController,
                          child: RotatedBox(
                            quarterTurns: rotateValue,
                            child: Transform(
                              transform: Matrix4(
                                1,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                                0,
                                0,
                                0,
                                1,
                                0,
                                x,
                                y,
                                0,
                                1 / scaleFactor,
                              )..rotateY(flipValue),
                              alignment: FractionalOffset.center,
                              child: layersStack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFutureButtons(context),
    );
  }

  Container _buildFutureButtons(BuildContext context) {
    List<Widget> widgets = [
      if (widget.features.contains(EditorFeature.crop))
        FeatureButton(
          icon: Icons.crop,
          onTap: crop,
        ),
      if (widget.features.contains(EditorFeature.brush))
        FeatureButton(
          icon: Icons.edit,
          onTap: brush,
        ),
      if (widget.features.contains(EditorFeature.text))
        FeatureButton(
          icon: Icons.text_fields,
          onTap: addText,
        ),
      if (widget.features.contains(EditorFeature.flip))
        FeatureButton(
          icon: Icons.flip,
          onTap: flip,
        ),
      if (widget.features.contains(EditorFeature.rotate))
        FeatureButton(
          icon: Icons.rotate_left,
          onTap: rotateLeft,
        ),
      if (widget.features.contains(EditorFeature.rotate))
        FeatureButton(
          icon: Icons.rotate_right,
          onTap: rotateRight,
        ),
      if (widget.features.contains(EditorFeature.blur))
        FeatureButton(
          icon: Icons.blur_on,
          onTap: blur,
        ),
      if (widget.features.contains(EditorFeature.filters))
        FeatureButton(
          icon: Icons.photo,
          onTap: filter,
        ),
      if (widget.features.contains(EditorFeature.emoji))
        FeatureButton(
          icon: Icons.face,
          onTap: emoji,
        ),
    ];

    return Container(
      alignment: Alignment.bottomCenter,
      height: 60 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.rectangle,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widgets.length,
        itemBuilder: (_, index) {
          if (index == 0 || index + 1 == widgets.length) {
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? AppDimensions.instance.paddingX(0.5) : 0,
                right: index + 1 == widgets.length
                    ? AppDimensions.instance.paddingX(0.5)
                    : 0,
              ),
              child: widgets[index],
            );
          }
          return widgets[index];
        },
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final VoidCallback? onTap, onLongPress;
  final IconData icon;
  final Color? color;

  const FeatureButton({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.instance.paddingX(0.5),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
