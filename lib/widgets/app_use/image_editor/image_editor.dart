import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapeditify/widgets/app_use/image_editor/data/editor_feature.dart';
import 'package:snapeditify/widgets/app_use/image_editor/single_image_editor.dart';
import 'utils.dart';

class ImageEditor extends StatelessWidget {
  final Uint8List? image;

  final int maxLength;
  final List<EditorFeature> features;
  final List<AspectRatioOption> cropAvailableRatios;
  final Function(Uint8List?)? onSave;

  const ImageEditor({
    super.key,
    this.image,
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
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null && !features.contains(EditorFeature.captureFromCamera) && !features.contains(EditorFeature.pickFromGallery)) {
      throw Exception('No image to work with, provide an image or allow the image picker.');
    }

    return SingleImageEditor(
      image: image,
      features: features,
      cropAvailableRatios: cropAvailableRatios,
      onSave: onSave,
    );
  }
}
