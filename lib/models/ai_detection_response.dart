import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:snapretouch/models/detected_object.dart';

class AIDetectionResponse {
  final List<DetectedObject> detectedObjects;
  final String eventId;
  final String sessionId;
  AIDetectionResponse({
    required this.detectedObjects,
    required this.eventId,
    required this.sessionId,
  });
  

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
    return {
      'detected_objects': detectedObjects.map((x) => x.toMap()).toList(),
      'event_id': eventId,
      'session_id': sessionId,
    };
  }

  factory AIDetectionResponse.fromMap(Map<String, dynamic> map) {
    return AIDetectionResponse(
      detectedObjects: List<DetectedObject>.from(map['detected_objects']?.map((x) => DetectedObject.fromMap(x))),
      eventId: map['eventId'] ?? '',
      sessionId: map['sessionId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AIDetectionResponse.fromJson(String source) => AIDetectionResponse.fromMap(json.decode(source));

  @override
  String toString() => 'AIDetectionResponse(detectedObjects: $detectedObjects, eventId: $eventId, sessionId: $sessionId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AIDetectionResponse &&
      listEquals(other.detectedObjects, detectedObjects) &&
      other.eventId == eventId &&
      other.sessionId == sessionId;
  }

  @override
  int get hashCode => detectedObjects.hashCode ^ eventId.hashCode ^ sessionId.hashCode;
}
