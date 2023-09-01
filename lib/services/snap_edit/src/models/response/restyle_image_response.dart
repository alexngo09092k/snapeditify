import 'dart:convert';

class RestyleImageResponse {
  final String imageId;
  final String outputImage;

  const RestyleImageResponse({
    required this.imageId,
    required this.outputImage,
  });

  RestyleImageResponse copyWith({
    String? imageId,
    String? outputImage,
  }) {
    return RestyleImageResponse(
      imageId: imageId ?? this.imageId,
      outputImage: outputImage ?? this.outputImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_id': imageId,
      'output_image': outputImage,
    };
  }

  factory RestyleImageResponse.fromMap(Map<String, dynamic> map) {
    return RestyleImageResponse(
      imageId: map['image_id'] ?? '',
      outputImage: map['output_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RestyleImageResponse.fromJson(String source) => RestyleImageResponse.fromMap(json.decode(source));

  @override
  String toString() => 'RestyleImageResponse(image_id: $imageId, output_image: $outputImage)';

  @override
  bool operator ==(covariant RestyleImageResponse other) {
    if (identical(this, other)) return true;

    return other.imageId == imageId && other.outputImage == outputImage;
  }

  @override
  int get hashCode => imageId.hashCode ^ outputImage.hashCode;
}
