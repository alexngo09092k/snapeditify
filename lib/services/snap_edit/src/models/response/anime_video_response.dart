// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnimeVideoResponse {
  final String imageId;
  final String videoUrl;

  AnimeVideoResponse({
    required this.imageId,
    required this.videoUrl,
  });

  AnimeVideoResponse copyWith({
    String? imageId,
    String? videoUrl,
  }) {
    return AnimeVideoResponse(
      imageId: imageId ?? this.imageId,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_id': imageId,
      'video_url': videoUrl,
    };
  }

  factory AnimeVideoResponse.fromMap(Map<String, dynamic> map) {
    return AnimeVideoResponse(
      imageId: map['image_id'] as String,
      videoUrl: map['video_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeVideoResponse.fromJson(String source) => AnimeVideoResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AnimeVideoResponse(imageId: $imageId, videoUrl: $videoUrl)';

  @override
  bool operator ==(covariant AnimeVideoResponse other) {
    if (identical(this, other)) return true;

    return other.imageId == imageId && other.videoUrl == videoUrl;
  }

  @override
  int get hashCode => imageId.hashCode ^ videoUrl.hashCode;
}
