import 'dart:convert';

class EditedImage {
  final String image;
  final String imageId;
  final String mask;

  const EditedImage({
    required this.image,
    required this.imageId,
    required this.mask,
  });

  EditedImage copyWith({
    String? image,
    String? imageId,
    String? mask,
  }) {
    return EditedImage(
      image: image ?? this.image,
      imageId: imageId ?? this.imageId,
      mask: mask ?? this.mask,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'image_id': imageId,
      'mask': mask,
    };
  }

  factory EditedImage.fromMap(Map<String, dynamic> map) {
    return EditedImage(
      image: map['image'],
      imageId: map['image_id'],
      mask: map['mask'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditedImage.fromJson(String source) => EditedImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EditedImage(image: $image, imageId: $imageId, mask: $mask)';

  @override
  bool operator ==(covariant EditedImage other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.imageId == imageId &&
        other.mask == mask;
  }

  @override
  int get hashCode => image.hashCode ^ imageId.hashCode ^ mask.hashCode;
}
