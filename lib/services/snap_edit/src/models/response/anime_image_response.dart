// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AnimeImageResponse {
  final String imageId;
  final List<AnimeImage> outputImages;
  AnimeImageResponse({
    required this.imageId,
    required this.outputImages,
  });

  AnimeImageResponse copyWith({
    String? imageId,
    List<AnimeImage>? outputImages,
  }) {
    return AnimeImageResponse(
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

  factory AnimeImageResponse.fromMap(Map<String, dynamic> map) {
    return AnimeImageResponse(
      imageId: map['image_id'] as String,
      outputImages: (map['output_images']).map<AnimeImage>(
        (x) => AnimeImage.fromMap(x as Map<String, dynamic>),
      ).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeImageResponse.fromJson(String source) => AnimeImageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnimeResponse(imageId: $imageId, outputImages: $outputImages)';

  @override
  bool operator ==(covariant AnimeImageResponse other) {
    if (identical(this, other)) return true;

    return other.imageId == imageId && listEquals(other.outputImages, outputImages);
  }

  @override
  int get hashCode => imageId.hashCode ^ outputImages.hashCode;
}

class AnimeImage {
  final String image;
  final String imageId;

  AnimeImage({
    required this.image,
    required this.imageId,
  });

  AnimeImage copyWith({
    String? image,
    String? imageId,
  }) {
    return AnimeImage(
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

  factory AnimeImage.fromMap(Map<String, dynamic> map) {
    return AnimeImage(
      image: map['image'] as String,
      imageId: map['image_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeImage.fromJson(String source) => AnimeImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnimeImage(image: $image, imageId: $imageId)';

  @override
  bool operator ==(covariant AnimeImage other) {
    if (identical(this, other)) return true;

    return other.image == image && other.imageId == imageId;
  }

  @override
  int get hashCode => image.hashCode ^ imageId.hashCode;
}
