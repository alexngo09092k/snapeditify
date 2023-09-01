import 'dart:typed_data';

class OneTouchSuggestionBody {
  final Uint8List? originalPreviewImage;
  final String? sessionId;

  const OneTouchSuggestionBody({
    this.originalPreviewImage,
    this.sessionId,
  });
}
