// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AdditionFace {
  final List<int> box;
  final int faceId;
  final List<String> png;

  const AdditionFace({
    required this.box,
    required this.faceId,
    required this.png,
  });

  AdditionFace copyWith({
    List<int>? box,
    int? faceId,
    List<String>? png,
  }) {
    return AdditionFace(
      box: box ?? this.box,
      faceId: faceId ?? this.faceId,
      png: png ?? this.png,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'box': box,
      'face_id': faceId,
      'png': png,
    };
  }

  factory AdditionFace.fromMap(Map<String, dynamic> map) {
    return AdditionFace(
      box: List<int>.from(map['box']),
      faceId: map['face_id'] as int,
      png: List<String>.from(map['png']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdditionFace.fromJson(String source) => AdditionFace.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AdditionFace(box: $box, face_id: $faceId, png: $png)';

  @override
  bool operator ==(covariant AdditionFace other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.box, box) &&
      other.faceId == faceId &&
      listEquals(other.png, png);
  }

  @override
  int get hashCode => box.hashCode ^ faceId.hashCode ^ png.hashCode;
}
