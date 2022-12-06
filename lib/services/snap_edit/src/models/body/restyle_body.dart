// ignore_for_file: public_member_api_docs, sort_constructors_first
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
