import 'package:flutter/foundation.dart';

class AnimeBody {
  final Uint8List? inputImage;
  final String? imageId;
  final String style;

  const AnimeBody({
    this.imageId,
    this.inputImage,
    required this.style,
  });
}
