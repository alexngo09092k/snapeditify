import 'dart:convert';

class EraseResponse {
  final String newImageBase64;
  final String sessionId;
  final String newImageId;
  final String oldImageId;
  final String eventId;

  EraseResponse({
    required this.newImageBase64,
    required this.sessionId,
    required this.newImageId,
    required this.oldImageId,
    required this.eventId,
  });

  EraseResponse copyWith({
    String? newImageBase64,
    String? sessionId,
    String? newImageId,
    String? oldImageId,
    String? eventId,
  }) {
    return EraseResponse(
      newImageBase64: newImageBase64 ?? this.newImageBase64,
      sessionId: sessionId ?? this.sessionId,
      newImageId: newImageId ?? this.newImageId,
      oldImageId: oldImageId ?? this.oldImageId,
      eventId: eventId ?? this.eventId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'new_image_base64': newImageBase64,
      'session_id': sessionId,
      'new_image_id': newImageId,
      'old_image_id': oldImageId,
      'event_id': eventId,
    };
  }

  factory EraseResponse.fromMap(Map<String, dynamic> map) {
    return EraseResponse(
      newImageBase64: map['new_image_base64'] ?? '',
      sessionId: map['session_id'] ?? '',
      newImageId: map['new_image_id'] ?? '',
      oldImageId: map['old_image_id'] ?? '',
      eventId: map['event_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EraseResponse.fromJson(String source) => EraseResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EraseResponse(newImageBase64: $newImageBase64, sessionId: $sessionId, newImageId: $newImageId, oldImageId: $oldImageId, eventId: $eventId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EraseResponse &&
        other.newImageBase64 == newImageBase64 &&
        other.sessionId == sessionId &&
        other.newImageId == newImageId &&
        other.oldImageId == oldImageId &&
        other.eventId == eventId;
  }

  @override
  int get hashCode {
    return newImageBase64.hashCode ^ sessionId.hashCode ^ newImageId.hashCode ^ oldImageId.hashCode ^ eventId.hashCode;
  }
}
