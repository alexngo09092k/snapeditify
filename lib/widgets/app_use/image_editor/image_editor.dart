import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapeditify/widgets/app_use/image_editor/data/editor_feature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/mutil_image_editor.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'utils.dart';

class ImageEditor extends StatelessWidget {
  final Uint8List? image;
  final List? images;

  final Directory? savePath;
  final int maxLength;
  final List<EditorFeature> features;
  final List<AspectRatioOption> cropAvailableRatios;

  const ImageEditor({
    super.key,
    this.image,
    this.images,
    this.savePath,
    this.maxLength = 99,
    Color? appBar,
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
  Widget build(BuildContext context) {
    if (images == null && image == null && !features.contains(EditorFeature.captureFromCamera) && !features.contains(EditorFeature.pickFromGallery)) {
      throw Exception('No image to work with, provide an image or allow the image picker.');
    }

    if (image != null) {
      return SingleImageEditor(
        image: image,
        savePath: savePath,
        features: features,
        cropAvailableRatios: cropAvailableRatios,
      );
    } else {
      return MultiImageEditor(
        images: images ?? [],
        savePath: savePath,
        maxLength: maxLength,
        features: features,
        cropAvailableRatios: cropAvailableRatios,
      );
    }
  }
}