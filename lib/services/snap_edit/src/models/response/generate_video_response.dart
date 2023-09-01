// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GenerateVideoResponse {
  final String imageId;
  final String outputVideoUrl;

  const GenerateVideoResponse({
    required this.imageId,
    required this.outputVideoUrl,
  });

  GenerateVideoResponse copyWith({
    String? imageId,
    String? outputVideoUrl,
  }) {
    return GenerateVideoResponse(
      imageId: imageId ?? this.imageId,
      outputVideoUrl: outputVideoUrl ?? this.outputVideoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_id': imageId,
      'output_video_url': outputVideoUrl,
    };
  }

  factory GenerateVideoResponse.fromMap(Map<String, dynamic> map) {
    return GenerateVideoResponse(
      imageId: map['image_id'] as String,
      outputVideoUrl: map['output_video_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GenerateVideoResponse.fromJson(String source) => GenerateVideoResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GenerateVideoResponse(image_id: $imageId, output_video_url: $outputVideoUrl)';

  @override
  bool operator ==(covariant GenerateVideoResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.imageId == imageId &&
      other.outputVideoUrl == outputVideoUrl;
  }

  @override
  int get hashCode => imageId.hashCode ^ outputVideoUrl.hashCode;
}
