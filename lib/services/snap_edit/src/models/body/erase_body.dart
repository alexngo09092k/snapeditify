// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/services.dart';

class EraseBody {
  final Uint8List? originalPreviewImage;
  final String? sessionId;

  final Uint8List? maskBrush;
  final Uint8List? maskBase;

  final String? maskObjects; // json

  EraseBody({
    this.originalPreviewImage,
    this.sessionId,
    this.maskBrush,
    this.maskBase,
    this.maskObjects,
  });
}
