
import 'dart:convert';

class OutputImage {
  final String image;
  final String imageId;

  const OutputImage({
    required this.image,
    required this.imageId,
  });

  OutputImage copyWith({
    String? image,
    String? imageId,
  }) {
    return OutputImage(
      image: image ?? this.image,
      imageId: imageId ?? this.imageId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'image_id': imageId,
    };
  }

  factory OutputImage.fromMap(Map<String, dynamic> map) {
    return OutputImage(
      image: map['image'] as String,
      imageId: map['image_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OutputImage.fromJson(String source) => OutputImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OutputImage(image: $image, imageId: $imageId)';

  @override
  bool operator ==(covariant OutputImage other) {
    if (identical(this, other)) return true;

    return other.image == image && other.imageId == imageId;
  }

  @override
  int get hashCode => image.hashCode ^ imageId.hashCode;
}
