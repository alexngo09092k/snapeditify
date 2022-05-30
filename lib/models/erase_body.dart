import 'dart:convert';

class EraseBody {
  final String originalImageBase64;
  final String maskBase64;

  EraseBody({
    required this.originalImageBase64,
    required this.maskBase64,
  });

  EraseBody copyWith({
    String? originalImageBase64,
    String? maskBase64,
  }) {
    return EraseBody(
      originalImageBase64: originalImageBase64 ?? this.originalImageBase64,
      maskBase64: maskBase64 ?? this.maskBase64,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'original_image_base64': originalImageBase64,
      'mask_base64': maskBase64,
    };
  }

  factory EraseBody.fromMap(Map<String, dynamic> map) {
    return EraseBody(
      originalImageBase64: map['original_image_base64'] ?? '',
      maskBase64: map['mask_base64'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EraseBody.fromJson(String source) =>
      EraseBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'EraseBody(originalImageBase64: $originalImageBase64, maskBase64: $maskBase64)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EraseBody &&
        other.originalImageBase64 == originalImageBase64 &&
        other.maskBase64 == maskBase64;
  }

  @override
  int get hashCode => originalImageBase64.hashCode ^ maskBase64.hashCode;
}
