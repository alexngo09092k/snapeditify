import 'dart:convert';
import 'edited_image.dart';

class RemoveObjectResponse {
  final EditedImage editedImage;
  final String eventId;
  final String sessionId;

  const RemoveObjectResponse({
    required this.editedImage,
    required this.eventId,
    required this.sessionId,
  });

  RemoveObjectResponse copyWith({
    EditedImage? editedImage,
    String? eventId,
    String? sessionId,
  }) {
    return RemoveObjectResponse(
      editedImage: editedImage ?? this.editedImage,
      eventId: eventId ?? this.eventId,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'edited_image': editedImage.toMap(),
      'event_id': eventId,
      'session_id': sessionId,
    };
  }

  factory RemoveObjectResponse.fromMap(Map<String, dynamic> map) {
    return RemoveObjectResponse(
      editedImage: EditedImage.fromMap(map['edited_image']),
      eventId: map['event_id'] as String,
      sessionId: map['session_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoveObjectResponse.fromJson(String source) => RemoveObjectResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RemoveObjectResponse(editedImage: $editedImage, eventId: $eventId, sessionId: $sessionId)';

  @override
  bool operator ==(covariant RemoveObjectResponse other) {
    if (identical(this, other)) return true;

    return other.editedImage == editedImage && other.eventId == eventId && other.sessionId == sessionId;
  }

  @override
  int get hashCode => editedImage.hashCode ^ eventId.hashCode ^ sessionId.hashCode;
}
