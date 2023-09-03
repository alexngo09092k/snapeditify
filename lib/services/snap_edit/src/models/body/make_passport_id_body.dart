import 'dart:typed_data';

class MakePassportIDBody {
  final Uint8List? inputImage;
  final String? imageId;

  const MakePassportIDBody({
    required this.inputImage,
    this.imageId,
  });
}
