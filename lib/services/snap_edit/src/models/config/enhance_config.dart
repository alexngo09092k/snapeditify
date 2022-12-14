import 'dart:convert';

import 'package:snapedit/services/snap_edit/src/models/config/dimension.dart';

class EnhanceConfig {
  final Dimension suportedImageSize;
  final Dimension uploadImageSize;
  final int upscaleMaxImageSize;

  const EnhanceConfig({
    required this.suportedImageSize,
    required this.uploadImageSize,
    required this.upscaleMaxImageSize,
  });

  factory EnhanceConfig.defaultValue() {
    return EnhanceConfig(
      suportedImageSize: Dimension.defaultValue(),
      uploadImageSize: Dimension.defaultValue(),
      upscaleMaxImageSize: 1000,
    );
  }

  EnhanceConfig copyWith({
    Dimension? suportedImageSize,
    Dimension? uploadImageSize,
    int? upscaleMaxImageSize,
  }) {
    return EnhanceConfig(
      suportedImageSize: suportedImageSize ?? this.suportedImageSize,
      uploadImageSize: uploadImageSize ?? this.uploadImageSize,
      upscaleMaxImageSize: upscaleMaxImageSize ?? this.upscaleMaxImageSize,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'suportedImageSize': suportedImageSize.toMap(),
      'uploadImageSize': uploadImageSize.toMap(),
      'upscaleMaxImageSize': upscaleMaxImageSize,
    };
  }

  factory EnhanceConfig.fromMap(Map<String, dynamic> map) {
    return EnhanceConfig.defaultValue().copyWith(
      suportedImageSize: Dimension.fromMap(map['suportedImageSize']),
      uploadImageSize: Dimension.fromMap(map['uploadImageSize']),
      upscaleMaxImageSize: map['upscaleMaxImageSize'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnhanceConfig.fromJson(String source) => EnhanceConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EnhanceConfig(suportedImageSize: $suportedImageSize, uploadImageSize: $uploadImageSize, upscaleMaxImageSize: $upscaleMaxImageSize)';

  @override
  bool operator ==(covariant EnhanceConfig other) {
    if (identical(this, other)) return true;

    return other.suportedImageSize == suportedImageSize &&
        other.uploadImageSize == uploadImageSize &&
        other.upscaleMaxImageSize == upscaleMaxImageSize;
  }

  @override
  int get hashCode => suportedImageSize.hashCode ^ uploadImageSize.hashCode ^ upscaleMaxImageSize.hashCode;
}
