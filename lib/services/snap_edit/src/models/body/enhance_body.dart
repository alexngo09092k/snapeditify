// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/services.dart';

class EnhanceBody {
  final String zoomFactor;
  final Uint8List? inputImage;
  final String? imageId;

  const EnhanceBody({
    this.zoomFactor = '2',
    this.inputImage,
    this.imageId,
  }) ;
}
