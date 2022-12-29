// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/services.dart';

class AIDetectionBody {
  final Uint8List? originalPreviewImage;
  final String? sessionId;

  AIDetectionBody({
    this.originalPreviewImage,
    this.sessionId,
  });
}
