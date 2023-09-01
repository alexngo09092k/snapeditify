import 'package:flutter/foundation.dart';

class RestyleBody {
  final Uint8List? inputImage;
  final String? imageId;
  final String styleId;

  const RestyleBody({
    this.imageId,
    this.inputImage,
    required this.styleId,
  });
}
