// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class EnhanceBody {
  String zoomFactor;
  File? inputImage;
  String? imageId;

  EnhanceBody({
    required this.zoomFactor,
    this.inputImage,
    this.imageId,
  }) ;
}
