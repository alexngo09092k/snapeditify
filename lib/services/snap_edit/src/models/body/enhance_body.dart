// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EnhanceBody {
  int zoomFactor;
  String inputImage;

  EnhanceBody({
    required this.zoomFactor,
    required this.inputImage,
  });

  EnhanceBody copyWith({
    int? zoomFactor,
    String? inputImage,
  }) {
    return EnhanceBody(
      zoomFactor: zoomFactor ?? this.zoomFactor,
      inputImage: inputImage ?? this.inputImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'zoom_factor': zoomFactor,
      'input_image': inputImage,
    };
  }

  factory EnhanceBody.fromMap(Map<String, dynamic> map) {
    return EnhanceBody(
      zoomFactor: map['zoom_factor'] as int,
      inputImage: map['input_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnhanceBody.fromJson(String source) => EnhanceBody.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EnhanceBody(zoomFactor: $zoomFactor, inputImage: $inputImage)';

  @override
  bool operator ==(covariant EnhanceBody other) {
    if (identical(this, other)) return true;

    return other.zoomFactor == zoomFactor && other.inputImage == inputImage;
  }

  @override
  int get hashCode => zoomFactor.hashCode ^ inputImage.hashCode;
}
