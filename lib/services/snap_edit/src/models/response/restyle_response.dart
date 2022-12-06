import 'dart:convert';

class RestyleResponse {
  String imageId;
  String outputImage;

  RestyleResponse({
    required this.imageId,
    required this.outputImage,
  });

  factory RestyleResponse.defaultValue() {
    return RestyleResponse(
      imageId: '',
      outputImage: '',
    );
  }

  RestyleResponse copyWith({
    String? imageId,
    String? outputImage,
  }) {
    return RestyleResponse(
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

  factory RestyleResponse.fromMap(Map<String, dynamic> map) {
    return RestyleResponse.defaultValue().copyWith(
      imageId: map['image_id'],
      outputImage: map['output_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RestyleResponse.fromJson(String source) => RestyleResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RestyleResponse(imageId: $imageId, outputImage: $outputImage)';

  @override
  bool operator ==(covariant RestyleResponse other) {
    if (identical(this, other)) return true;

    return other.imageId == imageId && other.outputImage == outputImage;
  }

  @override
  int get hashCode => imageId.hashCode ^ outputImage.hashCode;
}
