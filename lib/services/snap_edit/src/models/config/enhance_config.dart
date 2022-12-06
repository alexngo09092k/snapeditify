import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EnhanceConfig {
  /// max supported image size
  final int maxSupportedImageSize;

  /// premium max supported image size
  final int premiumMaxSupportedImageSize;

  /// premium upload image size
  final int premiumUploadImageSize;

  /// standard max supported image size
  final int standardMaxSupportedImageSize;

  /// standard upload image size
  final int standardUploadImageSize;

  /// up scale max image size
  final int upscaleMaxImageSize;

  EnhanceConfig({
    required this.maxSupportedImageSize,
    required this.premiumMaxSupportedImageSize,
    required this.premiumUploadImageSize,
    required this.standardMaxSupportedImageSize,
    required this.standardUploadImageSize,
    required this.upscaleMaxImageSize,
  });

  factory EnhanceConfig.defaultValue() {
    return EnhanceConfig(
      maxSupportedImageSize: 3000,
      premiumMaxSupportedImageSize: 3000,
      premiumUploadImageSize: 1200,
      standardMaxSupportedImageSize: 1200,
      standardUploadImageSize: 1200,
      upscaleMaxImageSize: 1000,
    );
  }

  EnhanceConfig copyWith({
    int? maxSupportedImageSize,
    int? premiumMaxSupportedImageSize,
    int? premiumUploadImageSize,
    int? standardMaxSupportedImageSize,
    int? standardUploadImageSize,
    int? upscaleMaxImageSize,
  }) {
    return EnhanceConfig(
      maxSupportedImageSize: maxSupportedImageSize ?? this.maxSupportedImageSize,
      premiumMaxSupportedImageSize: premiumMaxSupportedImageSize ?? this.premiumMaxSupportedImageSize,
      premiumUploadImageSize: premiumUploadImageSize ?? this.premiumUploadImageSize,
      standardMaxSupportedImageSize: standardMaxSupportedImageSize ?? this.standardMaxSupportedImageSize,
      standardUploadImageSize: standardUploadImageSize ?? this.standardUploadImageSize,
      upscaleMaxImageSize: upscaleMaxImageSize ?? this.upscaleMaxImageSize,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maxSupportedImageSize': maxSupportedImageSize,
      'premiumMaxSupportedImageSize': premiumMaxSupportedImageSize,
      'premiumUploadImageSize': premiumUploadImageSize,
      'standardMaxSupportedImageSize': standardMaxSupportedImageSize,
      'standardUploadImageSize': standardUploadImageSize,
      'upscaleMaxImageSize': upscaleMaxImageSize,
    };
  }

  factory EnhanceConfig.fromMap(Map<String, dynamic> map) {
    return EnhanceConfig.defaultValue().copyWith(
      maxSupportedImageSize: map['maxSupportedImageSize'],
      premiumMaxSupportedImageSize: map['premiumMaxSupportedImageSize'],
      premiumUploadImageSize: map['premiumUploadImageSize'],
      standardMaxSupportedImageSize: map['standardMaxSupportedImageSize'],
      standardUploadImageSize: map['standardUploadImageSize'],
      upscaleMaxImageSize: map['upscaleMaxImageSize'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnhanceConfig.fromJson(String source) => EnhanceConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnhanceConfig(maxSupportedImageSize: $maxSupportedImageSize, premiumMaxSupportedImageSize: $premiumMaxSupportedImageSize, premiumUploadImageSize: $premiumUploadImageSize, standardMaxSupportedImageSize: $standardMaxSupportedImageSize, standardUploadImageSize: $standardUploadImageSize, upscaleMaxImageSize: $upscaleMaxImageSize)';
  }

  @override
  bool operator ==(covariant EnhanceConfig other) {
    if (identical(this, other)) return true;

    return other.maxSupportedImageSize == maxSupportedImageSize &&
        other.premiumMaxSupportedImageSize == premiumMaxSupportedImageSize &&
        other.premiumUploadImageSize == premiumUploadImageSize &&
        other.standardMaxSupportedImageSize == standardMaxSupportedImageSize &&
        other.standardUploadImageSize == standardUploadImageSize &&
        other.upscaleMaxImageSize == upscaleMaxImageSize;
  }

  @override
  int get hashCode {
    return maxSupportedImageSize.hashCode ^
        premiumMaxSupportedImageSize.hashCode ^
        premiumUploadImageSize.hashCode ^
        standardMaxSupportedImageSize.hashCode ^
        standardUploadImageSize.hashCode ^
        upscaleMaxImageSize.hashCode;
  }
}
