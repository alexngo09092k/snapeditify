// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/services.dart';

class ScanObjectBody {
  final Uint8List? originalPreviewImage;
  final String? sessionId;

  const ScanObjectBody({
    this.originalPreviewImage,
    this.sessionId,
  });
}
