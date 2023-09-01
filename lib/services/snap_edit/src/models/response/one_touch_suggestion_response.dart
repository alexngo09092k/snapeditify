// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'detected_object.dart';

class OneTouchSuggestionResponse {
  final String eventId;
  final List<DetectedObject> detectedObjects;
  final String sessionId;
  final List<String> suggestObjectIds;

  const OneTouchSuggestionResponse({
    required this.eventId,
    required this.detectedObjects,
    required this.sessionId,
    required this.suggestObjectIds,
  });

  OneTouchSuggestionResponse copyWith({
    String? eventId,
    List<DetectedObject>? detectedObjects,
    String? sessionId,
    List<String>? suggestObjectIds,
  }) {
    return OneTouchSuggestionResponse(
      eventId: eventId ?? this.eventId,
      detectedObjects: detectedObjects ?? this.detectedObjects,
      sessionId: sessionId ?? this.sessionId,
      suggestObjectIds: suggestObjectIds ?? this.suggestObjectIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event_id': eventId,
      'detected_objects': detectedObjects.map((x) => x.toMap()).toList(),
      'session_id': sessionId,
      'suggest_object_ids': suggestObjectIds,
    };
  }

  factory OneTouchSuggestionResponse.fromMap(Map<String, dynamic> map) {
    return OneTouchSuggestionResponse(
      eventId: map['event_id'] as String,
      detectedObjects: List<DetectedObject>.from((map['detected_objects']).map<DetectedObject>((x) => DetectedObject.fromMap(x))),
      sessionId: map['session_id'] as String,
      suggestObjectIds: List<String>.from((map['suggest_object_ids'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory OneTouchSuggestionResponse.fromJson(String source) =>
      OneTouchSuggestionResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OneTouchSuggestionResponse(event_id: $eventId, detected_objects: $detectedObjects, session_id: $sessionId, suggest_object_ids: $suggestObjectIds)';
  }

  @override
  bool operator ==(covariant OneTouchSuggestionResponse other) {
    if (identical(this, other)) return true;

    return other.eventId == eventId && listEquals(other.detectedObjects, detectedObjects) && other.sessionId == sessionId && listEquals(other.suggestObjectIds, suggestObjectIds);
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
        detectedObjects.hashCode ^
        sessionId.hashCode ^
        suggestObjectIds.hashCode;
  }
}
