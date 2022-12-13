import 'dart:io';

class RestyleBody {
  File? inputImage;
  String? imageId;
  String styleId;

  RestyleBody({
    this.imageId,
    this.inputImage,
    required this.styleId,
  });
}
