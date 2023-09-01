import 'dart:convert';

class EraseResponse {
  EditedImage editedImage;
  String eventId;
  String sessionId;

  EraseResponse({
    required this.editedImage,
    required this.eventId,
    required this.sessionId,
  });

  factory EraseResponse.defaultValue() {
    return EraseResponse(
      editedImage: EditedImage.defaultValue(),
      eventId: '',
      sessionId: '',
    );
  }

  EraseResponse copyWith({
    EditedImage? editedImage,
    String? eventId,
    String? sessionId,
  }) {
    return EraseResponse(
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

  factory EraseResponse.fromMap(Map<String, dynamic> map) {
    return EraseResponse(
      editedImage: EditedImage.fromMap(map['edited_image'] as Map<String, dynamic>),
      eventId: map['event_id'] as String,
      sessionId: map['session_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EraseResponse.fromJson(String source) => EraseResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EraseResponse(editedImage: $editedImage, eventId: $eventId, sessionId: $sessionId)';

  @override
  bool operator ==(covariant EraseResponse other) {
    if (identical(this, other)) return true;

    return other.editedImage == editedImage && other.eventId == eventId && other.sessionId == sessionId;
  }

  @override
  int get hashCode => editedImage.hashCode ^ eventId.hashCode ^ sessionId.hashCode;
}

class EditedImage {
  String image;
  String imageId;
  String mask;

  EditedImage({
    required this.image,
    required this.imageId,
    required this.mask,
  });

  factory EditedImage.defaultValue() {
    return EditedImage(
      image: '',
      imageId: '',
      mask: '',
    );
  }

  EditedImage copyWith({
    String? image,
    String? imageId,
    String? mask,
  }) {
    return EditedImage(
      image: image ?? this.image,
      imageId: imageId ?? this.imageId,
      mask: mask ?? this.mask,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'image_id': imageId,
      'mask': mask,
    };
  }

  factory EditedImage.fromMap(Map<String, dynamic> map) {
    return EditedImage.defaultValue().copyWith(
      image: map['image'],
      imageId: map['image_id'],
      mask: map['mask'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditedImage.fromJson(String source) => EditedImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EditedImage(image: $image, imageId: $imageId, mask: $mask)';

  @override
  bool operator ==(covariant EditedImage other) {
    if (identical(this, other)) return true;

    return other.image == image && other.imageId == imageId && other.mask == mask;
  }

  @override
  int get hashCode => image.hashCode ^ imageId.hashCode ^ mask.hashCode;
}
