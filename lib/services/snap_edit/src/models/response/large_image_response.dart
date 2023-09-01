// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LargeImageResponse {
  final String imageId;
  final String largeEditedImageBase64;
  final String largeImageToSave;
  final String eventId;
  final String sessionId;

  const LargeImageResponse({
    required this.imageId,
    required this.largeEditedImageBase64,
    required this.largeImageToSave,
    required this.eventId,
    required this.sessionId,
  });

  LargeImageResponse copyWith({
    String? imageId,
    String? largeEditedImageBase64,
    String? largeImageToSave,
    String? eventId,
    String? sessionId,
  }) {
    return LargeImageResponse(
      imageId: imageId ?? this.imageId,
      largeEditedImageBase64: largeEditedImageBase64 ?? this.largeEditedImageBase64,
      largeImageToSave: largeImageToSave ?? this.largeImageToSave,
      eventId: eventId ?? this.eventId,
      sessionId: sessionId ?? this.sessionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image_id': imageId,
      'large_edited_image_base64': largeEditedImageBase64,
      'large_image_to_save': largeImageToSave,
      'event_id': eventId,
      'session_id': sessionId,
    };
  }

  factory LargeImageResponse.fromMap(Map<String, dynamic> map) {
    return LargeImageResponse(
      imageId: map['imageId'] as String,
      largeEditedImageBase64: map['large_edited_image_base64'] as String,
      largeImageToSave: map['large_image_to_save'] as String,
      eventId: map['event_id'] as String,
      sessionId: map['session_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LargeImageResponse.fromJson(String source) => LargeImageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LargeImageResponse(image_id: $imageId, large_edited_image_base64: $largeEditedImageBase64, large_image_to_save: $largeImageToSave, event_id: $eventId, session_id: $sessionId)';
  }

  @override
  bool operator ==(covariant LargeImageResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.imageId == imageId &&
      other.largeEditedImageBase64 == largeEditedImageBase64 &&
      other.largeImageToSave == largeImageToSave &&
      other.eventId == eventId &&
      other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    return imageId.hashCode ^
      largeEditedImageBase64.hashCode ^
      largeImageToSave.hashCode ^
      eventId.hashCode ^
      sessionId.hashCode;
  }
}
