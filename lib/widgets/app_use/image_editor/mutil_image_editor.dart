import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapeditify/widgets/app_use/image_editor/data/editor_feature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_editor_storage.dart';
import 'package:snapeditify/widgets/app_use/image_editor/image_filters.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'data/image_item.dart';
import 'utils.dart';
import 'package:image_picker/image_picker.dart';

class MultiImageEditor extends StatefulWidget {
  final Directory? savePath;
  final List images;
  final int maxLength;
  final List<EditorFeature> features;
  final List<AspectRatioOption> cropAvailableRatios;

  const MultiImageEditor({
    super.key,
    this.images = const [],
    this.savePath,
    this.maxLength = 99,
    this.features = EditorFeature.values,
    this.cropAvailableRatios = const [
      AspectRatioOption(title: 'Freeform'),
      AspectRatioOption(title: '1:1', ratio: 1),
      AspectRatioOption(title: '4:3', ratio: 4 / 3),
      AspectRatioOption(title: '5:4', ratio: 5 / 4),
      AspectRatioOption(title: '7:5', ratio: 7 / 5),
      AspectRatioOption(title: '16:9', ratio: 16 / 9),
    ],
  });

  @override
  createState() => _MultiImageEditorState();
}

class _MultiImageEditorState extends State<MultiImageEditor> {
  List<ImageItem> images = [];

  @override
  void initState() {
    images = widget.images.map((e) => ImageItem(e)).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageEditorStorage.instance.viewportSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          const BackButton(),
          const Spacer(),
          if (images.length < widget.maxLength && widget.features.contains(EditorFeature.pickFromGallery))
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              icon: const Icon(Icons.photo),
              onPressed: () async {
                var selected = await picker.pickMultiImage();

                images.addAll(selected.map((e) => ImageItem(e)).toList());
                setState(() {});
              },
            ),
          if (images.length < widget.maxLength && widget.features.contains(EditorFeature.captureFromCamera))
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                var selected =
                    await picker.pickImage(source: ImageSource.camera);

                if (selected == null) return;

                images.add(ImageItem(selected));
                setState(() {});
              },
            ),
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            icon: const Icon(Icons.check),
            onPressed: () async {
              Navigator.pop(context, images);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 332,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 32),
                  for (var image in images)
                    Stack(children: [
                      GestureDetector(
                        onTap: () async {
                          var img = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleImageEditor(
                                image: image,
                              ),
                            ),
                          );

                          if (img != null) {
                            image.load(img);
                            setState(() {});
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 32, right: 32, bottom: 32),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border:
                                Border.all(color: Colors.white.withAlpha(80)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.memory(
                              image.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 36,
                        right: 36,
                        child: Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(60),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            iconSize: 20,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              images.remove(image);
                              setState(() {});
                            },
                            icon: const Icon(Icons.clear_outlined),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 32,
                        left: 0,
                        child: Container(
                          height: 38,
                          width: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(19),
                            ),
                          ),
                          child: IconButton(
                            iconSize: 20,
                            padding: const EdgeInsets.all(0),
                            onPressed: () async {
                              Uint8List? editedImage = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageFilters(
                                    image: image.image,
                                  ),
                                ),
                              );

                              if (editedImage != null) {
                                image.load(editedImage);
                              }
                            },
                            icon: const Icon(Icons.photo_filter_sharp),
                          ),
                        ),
                      ),
                    ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();
}
