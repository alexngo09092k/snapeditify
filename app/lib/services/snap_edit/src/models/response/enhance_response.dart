import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'addition_face.dart';

class EnhanceImageResponse {
  final List<AdditionFace> faces;
  final int numFaceModels;
  final int numTotalFaces;
  final List<String> outputImages;
  final String? error;
  

  const EnhanceImageResponse({
    required this.faces,
    required this.numFaceModels,
    required this.numTotalFaces,
    required this.outputImages,
    this.error,
  });

  factory EnhanceImageResponse.defaultValue() {
    return const EnhanceImageResponse(
      faces: [],
      numFaceModels: 0,
      numTotalFaces: 0,
      outputImages: [],
    );
  }

  EnhanceImageResponse copyWith({
    List<AdditionFace>? faces,
    int? numFaceModels,
    int? numTotalFaces,
    List<String>? outputImages,
    String? error,
  }) {
    return EnhanceImageResponse(
      faces: faces ?? this.faces,
      numFaceModels: numFaceModels ?? this.numFaceModels,
      numTotalFaces: numTotalFaces ?? this.numTotalFaces,
      outputImages: outputImages ?? this.outputImages,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'faces': faces.map((x) => x.toMap()).toList(),
      'num_face_models': numFaceModels,
      'num_total_faces': numTotalFaces,
      'output_images': outputImages,
      'error': error,
    };
  }

  factory EnhanceImageResponse.fromMap(Map<String, dynamic> map) {
    return EnhanceImageResponse(
      faces: List<AdditionFace>.from((map['faces']).map<AdditionFace>((x) => AdditionFace.fromMap(x))),
      numFaceModels: map['num_face_models'] as int,
      numTotalFaces: map['num_total_faces'] as int,
      outputImages: List<String>.from((map['output_images'])),
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnhanceImageResponse.fromJson(String source) => EnhanceImageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnhanceImageResponse(faces: $faces, num_face_models: $numFaceModels, num_total_faces: $numTotalFaces, output_images: $outputImages, error: $error)';
  }

  @override
  bool operator ==(covariant EnhanceImageResponse other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.faces, faces) &&
      other.numFaceModels == numFaceModels &&
      other.numTotalFaces == numTotalFaces &&
      listEquals(other.outputImages, outputImages) &&
      other.error == error;
  }

  @override
  int get hashCode {
    return faces.hashCode ^
      numFaceModels.hashCode ^
      numTotalFaces.hashCode ^
      outputImages.hashCode ^
      error.hashCode;
  }
}
