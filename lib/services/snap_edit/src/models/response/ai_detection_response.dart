// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AIDetectionResponse {
  List<DetectedObject> detectedObjects;
  String eventId;
  String sessionId;

  AIDetectionResponse({
    required this.detectedObjects,
    required this.eventId,
    required this.sessionId,
  });

  factory AIDetectionResponse.defaultValue() {
    return AIDetectionResponse(
      detectedObjects: [],
      eventId: '',
      sessionId: '',
    );
  }

  AIDetectionResponse copyWith({
    List<DetectedObject>? detectedObjects,
    String? eventId,
    String? sessionId,
  }) {
    return AIDetectionResponse(
      detectedObjects: detectedObjects ?? this.detectedObjects,
      eventId: eventId ?? this.eventId,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'detected_objects': detectedObjects.map((x) => x.toMap()).toList(),
      'event_id': eventId,
      'session_id': sessionId,
    };
  }

  factory AIDetectionResponse.fromMap(Map<String, dynamic> map) {
    return AIDetectionResponse.defaultValue().copyWith(
      detectedObjects: List<DetectedObject>.from(
        (map['detected_objects'] ?? []).map<DetectedObject>(
          (x) => DetectedObject.fromMap(x as Map<String, dynamic>),
        ),
      ),
      eventId: map['event_id'],
      sessionId: map['session_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AIDetectionResponse.fromJson(String source) => AIDetectionResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AIDetectionResponse(detectedObjects: $detectedObjects, eventId: $eventId, sessionId: $sessionId)';

  @override
  bool operator ==(covariant AIDetectionResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.detectedObjects, detectedObjects) && other.eventId == eventId && other.sessionId == sessionId;
  }

  @override
  int get hashCode => detectedObjects.hashCode ^ eventId.hashCode ^ sessionId.hashCode;
}

class DetectedObject {
  String accuracy;
  List<int> box;
  String mask;
  int maskId;
  String objectDescription;
  DetectedObjectType objectType;

  DetectedObject({
    required this.accuracy,
    required this.box,
    required this.mask,
    required this.maskId,
    required this.objectDescription,
    required this.objectType,
  });

  factory DetectedObject.defaultValue() {
    return DetectedObject(
      accuracy: '',
      box: [],
      mask: '',
      maskId: 0,
      objectDescription: '',
      objectType: DetectedObjectType.other,
    );
  }

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
      'object_type': objectType.name,
    };
  }

  factory DetectedObject.fromMap(Map<String, dynamic> map) {
    return DetectedObject.defaultValue().copyWith(
      accuracy: map['accuracy'],
      box: List<int>.from(((map['box'] ?? []).map<int>((e) => e as int))),
      mask: map['mask'],
      maskId: map['mask_id'],
      objectDescription: map['object_description'],
      objectType: DetectedObjectType.values.firstWhere((element) => element.name == map['object_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetectedObject.fromJson(String source) => DetectedObject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DetectedObject(accuracy: $accuracy, box: $box, mask: $mask, maskId: $maskId, objectDescription: $objectDescription, objectType: $objectType)';
  }

  @override
  bool operator ==(covariant DetectedObject other) {
    if (identical(this, other)) return true;

    return other.accuracy == accuracy &&
        listEquals(other.box, box) &&
        other.mask == mask &&
        other.maskId == maskId &&
        other.objectDescription == objectDescription &&
        other.objectType == objectType;
  }

  @override
  int get hashCode {
    return accuracy.hashCode ^ box.hashCode ^ mask.hashCode ^ maskId.hashCode ^ objectDescription.hashCode ^ objectType.hashCode;
  }
}

enum DetectedObjectType {
  other,
  person,
}
