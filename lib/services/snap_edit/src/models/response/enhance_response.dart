import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnhanceResponse {
  List<Face> faces;
  int numFaceModels;
  int numTotalFaces;
  List<String> outputImages;

  EnhanceResponse({
    required this.faces,
    required this.numFaceModels,
    required this.numTotalFaces,
    required this.outputImages,
  });

  factory EnhanceResponse.defaultValue() {
    return EnhanceResponse(
      faces: [],
      numFaceModels: 0,
      numTotalFaces: 0,
      outputImages: [],
    );
  }

  EnhanceResponse copyWith({
    List<Face>? faces,
    int? numFaceModels,
    int? numTotalFaces,
    List<String>? outputImages,
  }) {
    return EnhanceResponse(
      faces: faces ?? this.faces,
      numFaceModels: numFaceModels ?? this.numFaceModels,
      numTotalFaces: numTotalFaces ?? this.numTotalFaces,
      outputImages: outputImages ?? this.outputImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'faces': faces.map((face) => face.toMap()).toList(),
      'num_face_models': numFaceModels,
      'num_total_faces': numTotalFaces,
      'output_images': outputImages,
    };
  }

  factory EnhanceResponse.fromMap(Map<String, dynamic> map) {
    return EnhanceResponse.defaultValue().copyWith(
      faces: List<Face>.from((map['faces'] ?? []).map<Face>((e) => Face.fromMap(e))),
      numFaceModels: map['num_face_models'],
      numTotalFaces: map['num_total_faces'],
      outputImages: List<String>.from((map['output_images'] ?? []).map<String>((e) => e.toString())),
    );
  }

  String toJson() => json.encode(toMap());

  factory EnhanceResponse.fromJson(String source) => EnhanceResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnhanceResponse(faces: $faces, numFaceModels: $numFaceModels, numTotalFaces: $numTotalFaces, outputImages: $outputImages)';
  }

  @override
  bool operator ==(covariant EnhanceResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.faces, faces) &&
        other.numFaceModels == numFaceModels &&
        other.numTotalFaces == numTotalFaces &&
        listEquals(other.outputImages, outputImages);
  }

  @override
  int get hashCode {
    return faces.hashCode ^ numFaceModels.hashCode ^ numTotalFaces.hashCode ^ outputImages.hashCode;
  }
}

class Face {
  List<int> box;
  int faceId;
  List<String> png;

  Face({
    required this.box,
    required this.faceId,
    required this.png,
  });

  factory Face.defaultValue() {
    return Face(
      box: [],
      faceId: 0,
      png: [],
    );
  }

  Face copyWith({
    List<int>? box,
    int? faceId,
    List<String>? png,
  }) {
    return Face(
      box: box ?? this.box,
      faceId: faceId ?? this.faceId,
      png: png ?? this.png,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'box': box,
      'faceId': faceId,
      'png': png,
    };
  }

  factory Face.fromMap(Map<String, dynamic> map) {
    return Face.defaultValue().copyWith(
      box: List<int>.from(((map['box'] ?? []).map<int>((e) => int.parse(e.toString())))),
      faceId: map['faceId'],
      png: List<String>.from(((map['png'] ?? []).map<String>((e) => e.toString()))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Face.fromJson(String source) => Face.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Face(box: $box, faceId: $faceId, png: $png)';

  @override
  bool operator ==(covariant Face other) {
    if (identical(this, other)) return true;

    return listEquals(other.box, box) && other.faceId == faceId && listEquals(other.png, png);
  }

  @override
  int get hashCode => box.hashCode ^ faceId.hashCode ^ png.hashCode;
}
