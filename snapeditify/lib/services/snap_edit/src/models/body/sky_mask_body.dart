// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class SkyMaskBody {
  final Uint8List? inputImage;
  final String? imageId;
  final String styleId;

  const SkyMaskBody({
    this.inputImage,
    this.imageId,
    required this.styleId,
  });
}
