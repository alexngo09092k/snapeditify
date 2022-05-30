import 'dart:convert';

class AIDetectionBody  {
  final String originalImageBase64;

  AIDetectionBody ({
    required this.originalImageBase64,
  });

  AIDetectionBody  copyWith({
    String? originalImageBase64,
  }) {
    return AIDetectionBody (
      originalImageBase64: originalImageBase64 ?? this.originalImageBase64,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'original_image_base64': originalImageBase64,
    };
  }

  factory AIDetectionBody .fromMap(Map<String, dynamic> map) {
    return AIDetectionBody (
      originalImageBase64: map['original_image_base64'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AIDetectionBody .fromJson(String source) =>
      AIDetectionBody .fromMap(json.decode(source));

  @override
  String toString() =>
      'AIDetectionBody  (originalImageBase64: $originalImageBase64)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AIDetectionBody  &&
        other.originalImageBase64 == originalImageBase64;
  }

  @override
  int get hashCode => originalImageBase64.hashCode;
}
