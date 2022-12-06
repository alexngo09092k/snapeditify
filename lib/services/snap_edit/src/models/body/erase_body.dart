// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class EraseBody {
  final File? originalPreviewImage;
  final String? sessionId;

  final File? maskBrush;
  final File? maskBase;

  final String? maskObjects; // json

  EraseBody({
    this.originalPreviewImage,
    this.sessionId,
    this.maskBrush,
    this.maskBase,
    this.maskObjects,
  });
}
