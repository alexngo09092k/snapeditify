
import 'package:flutter/foundation.dart';

class RestyleBody {
  Uint8List? inputImage;
  String? imageId;
  String styleId;

  RestyleBody({
    this.imageId,
    this.inputImage,
    required this.styleId,
  });
}
