// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/services.dart';

class EnhanceBody {
  String zoomFactor;
  Uint8List? inputImage;
  String? imageId;

  EnhanceBody({
    this.zoomFactor = '2',
    this.inputImage,
    this.imageId,
  }) ;
}
