import 'dart:typed_data';

class LargeImageBody {
  final String? sessionId;
  final Uint8List? inputImage;

  const LargeImageBody({
    this.sessionId,
    this.inputImage,
  });
}
