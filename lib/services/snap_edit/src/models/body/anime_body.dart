import 'package:flutter/foundation.dart';

class AnimeBody {
  Uint8List? inputImage;
  String? imageId;
  String styleId;

  AnimeBody({
    this.imageId,
    this.inputImage,
    required this.styleId,
  });
}
