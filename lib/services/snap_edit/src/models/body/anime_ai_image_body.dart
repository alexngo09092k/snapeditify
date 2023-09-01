import 'package:flutter/foundation.dart';

class AnimeAIImageBody {
  Uint8List? inputImage;
  String? imageId;
  String style;

  AnimeAIImageBody({
    this.imageId,
    this.inputImage,
    required this.style,
  });
}
