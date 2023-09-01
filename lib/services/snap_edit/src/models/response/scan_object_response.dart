// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'detected_object.dart';

class ScanObjectResponse {
  final List<DetectedObject> detectedObjects;
  final String eventId;
  final String sessionId;

  const ScanObjectResponse({
    required this.detectedObjects,
    required this.eventId,
    required this.sessionId,
  });

  factory ScanObjectResponse.defaultValue() {
    return const ScanObjectResponse(
      detectedObjects: [],
      eventId: '',
      sessionId: '',
    );
  }

  ScanObjectResponse copyWith({
    List<DetectedObject>? detectedObjects,
    String? eventId,
    String? sessionId,
  }) {
    return ScanObjectResponse(
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

  factory ScanObjectResponse.fromMap(Map<String, dynamic> map) {
    return ScanObjectResponse.defaultValue().copyWith(
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

  factory ScanObjectResponse.fromJson(String source) => ScanObjectResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ScanObjectResponse(detectedObjects: $detectedObjects, eventId: $eventId, sessionId: $sessionId)';

  @override
  bool operator ==(covariant ScanObjectResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.detectedObjects, detectedObjects) && other.eventId == eventId && other.sessionId == sessionId;
  }

  @override
  int get hashCode => detectedObjects.hashCode ^ eventId.hashCode ^ sessionId.hashCode;
}