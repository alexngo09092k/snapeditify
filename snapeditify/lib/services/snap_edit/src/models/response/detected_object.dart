import 'dart:convert';
import 'package:flutter/foundation.dart';

enum DetectedObjectType {
  person,
  other,
}

extension DetectObjectTypeEx on DetectedObjectType {
  String get label {
    switch (this) {
      case DetectedObjectType.person:
      return 'person';
      case DetectedObjectType.other:
      return 'Other';
      default:
      throw 'DONT SUPPORT TYPE';
    }
  }
}

class DetectedObject {
  final String accuracy;
  final List<int> box;
  final String mask;
  final int maskId;
  final String objectDescription;
  final DetectedObjectType objectType;

  DetectedObject({
    required this.accuracy,
    required this.box,
    required this.mask,
    required this.maskId,
    required this.objectDescription,
    required this.objectType,
  });

  DetectedObject copyWith({
    String? accuracy,
    List<int>? box,
    String? mask,
    int? maskId,
    String? objectDescription,
    DetectedObjectType? objectType,
  }) {
    return DetectedObject(
      accuracy: accuracy ?? this.accuracy,
      box: box ?? this.box,
      mask: mask ?? this.mask,
      maskId: maskId ?? this.maskId,
      objectDescription: objectDescription ?? this.objectDescription,
      objectType: objectType ?? this.objectType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accuracy': accuracy,
      'box': box,
      'mask': mask,
      'mask_id': maskId,
      'object_description': objectDescription,
      'object_type': objectType,
    };
  }

  factory DetectedObject.fromMap(Map<String, dynamic> map) {
    return DetectedObject(
      accuracy: map['accuracy'] as String,
      box: List<int>.from(map['box']),
      mask: map['mask'] as String,
      maskId: map['mask_id'] as int,
      objectDescription: map['object_description'] as String,
      objectType: DetectedObjectType.values.firstWhere((element) => element.name == map['object_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetectedObject.fromJson(String source) => DetectedObject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DetectedObject(accuracy: $accuracy, box: $box, mask: $mask, mask_id: $maskId, object_description: $objectDescription, object_type: $objectType)';
  }

  @override
  bool operator ==(covariant DetectedObject other) {
    if (identical(this, other)) return true;
  
    return 
      other.accuracy == accuracy &&
      listEquals(other.box, box) &&
      other.mask == mask &&
      other.maskId == maskId &&
      other.objectDescription == objectDescription &&
      other.objectType == objectType;
  }

  @override
  int get hashCode {
    return accuracy.hashCode ^
      box.hashCode ^
      mask.hashCode ^
      maskId.hashCode ^
      objectDescription.hashCode ^
      objectType.hashCode;
  }
}
