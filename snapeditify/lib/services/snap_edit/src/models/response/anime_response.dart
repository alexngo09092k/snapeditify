// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'output_image.dart';

class AnimeResponse {
  final String imageId;
  final List<OutputImage> outputImages;
  
  const AnimeResponse({
    required this.imageId,
    required this.outputImages,
  });

  AnimeResponse copyWith({
    String? imageId,
    List<OutputImage>? outputImages,
  }) {
    return AnimeResponse(
      imageId: imageId ?? this.imageId,
      outputImages: outputImages ?? this.outputImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_id': imageId,
      'output_images': outputImages.map((x) => x.toMap()).toList(),
    };
  }

  factory AnimeResponse.fromMap(Map<String, dynamic> map) {
    return AnimeResponse(
      imageId: map['image_id'] as String,
      outputImages: (map['output_images']).map<OutputImage>(
        (x) => OutputImage.fromMap(x),
      ).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeResponse.fromJson(String source) => AnimeResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnimeResponse(image_id: $imageId, output_images: $outputImages)';

  @override
  bool operator ==(covariant AnimeResponse other) {
    if (identical(this, other)) return true;

    return other.imageId == imageId && listEquals(other.outputImages, outputImages);
  }

  @override
  int get hashCode => imageId.hashCode ^ outputImages.hashCode;
}
