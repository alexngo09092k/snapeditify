import 'dart:convert';
import 'output_image.dart';

class RestorationResponse {
  final String imageId;
  final OutputImage outputImage;

  const RestorationResponse({
    required this.imageId,
    required this.outputImage,
  });

  RestorationResponse copyWith({
    String? imageId,
    OutputImage? outputImage,
  }) {
    return RestorationResponse(
      imageId: imageId ?? this.imageId,
      outputImage: outputImage ?? this.outputImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_id': imageId,
      'output_image': outputImage.toMap(),
    };
  }

  factory RestorationResponse.fromMap(Map<String, dynamic> map) {
    return RestorationResponse(
      imageId: map['image_id'] as String,
      outputImage: OutputImage.fromMap(map['output_image'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestorationResponse.fromJson(String source) =>
      RestorationResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RestorationResponse(image_id: $imageId, output_image: $outputImage)';

  @override
  bool operator ==(covariant RestorationResponse other) {
    if (identical(this, other)) return true;

    return other.imageId == imageId && other.outputImage == outputImage;
  }

  @override
  int get hashCode => imageId.hashCode ^ outputImage.hashCode;
}