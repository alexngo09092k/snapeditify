// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EndPoints {
  final String removeObject;
  final String scanObject;
  final String enhanceImage;
  final String restyleImage;
  final String restyleEffects;
  final String animeImage;
  final String animeEffects;
  final String generateVideo;
  final String removeBackground;
  final String backgroundEffects;
  final String removeOneTouch;
  final String saveImagelarge;
  final String skyImage;
  final String skyEffects;
  final String restoreImage;

  const EndPoints({
    required this.removeObject,
    required this.scanObject,
    required this.enhanceImage,
    required this.restyleImage,
    required this.restyleEffects,
    required this.animeImage,
    required this.animeEffects,
    required this.generateVideo,
    required this.removeBackground,
    required this.backgroundEffects,
    required this.removeOneTouch,
    required this.saveImagelarge,
    required this.skyImage,
    required this.skyEffects,
    required this.restoreImage,
  });

  factory EndPoints.defaultValue() {
    return const EndPoints(
      removeObject: "api/object_removal/v5/erase",
      removeOneTouch: "api/object_removal/v5/onetouch_suggest",
      scanObject: "api/v6/ai_detection",
      enhanceImage: "api/v2/pro/enhance",
      restyleEffects: "https://assets.snapedit.app/restyle/styles.json",
      restyleImage: "api/v1/restyle",
      animeEffects: "https://assets.snapedit.app/imagen/styles.json",
      animeImage: "api/imagen/v1",
      generateVideo: "api/video/v1/generate",
      removeBackground: "api/rmbg/v1",
      backgroundEffects: "https://assets.snapedit.app/removebg/backgrounds.json",
      saveImagelarge: "api/v6/save_large_image",
      skyImage: "api/sky/v1",
      skyEffects: "https://assets.snapedit.app/skywizard/backgrounds.json",
      restoreImage: "api/restore/v1",
    );
  }

  factory EndPoints.fromMap(Map<String, dynamic> map) {
    return EndPoints(
      removeObject: map['removeObject'] as String,
      scanObject: map['scanObject'] as String,
      enhanceImage: map['enhanceImage'] as String,
      restyleImage: map['restyleImage'] as String,
      restyleEffects: map['restyleEffects'] as String,
      animeImage: map['animeImage'] as String,
      animeEffects: map['animeEffects'] as String,
      generateVideo: map['generateVideo'] as String,
      removeBackground: map['removeBackground'] as String,
      backgroundEffects: map['backgroundEffects'] as String,
      removeOneTouch: map['removeOneTouch'] as String,
      saveImagelarge: map['saveImagelarge'] as String,
      skyImage: map['skyImage'] as String,
      skyEffects: map['skyEffects'] as String,
      restoreImage: map['restoreImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EndPoints.fromJson(String source) => EndPoints.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EndPoints(removeObject: $removeObject, scanObject: $scanObject, enhanceImage: $enhanceImage, restyleImage: $restyleImage, restyleEffects: $restyleEffects, animeImage: $animeImage, animeEffects: $animeEffects, generateVideo: $generateVideo, removeBackground: $removeBackground, backgroundEffects: $backgroundEffects, removeOneTouch: $removeOneTouch, saveImagelarge: $saveImagelarge, skyImage: $skyImage, skyEffects: $skyEffects, restoreImage: $restoreImage)';
  }

  @override
  bool operator ==(covariant EndPoints other) {
    if (identical(this, other)) return true;
  
    return 
      other.removeObject == removeObject &&
      other.scanObject == scanObject &&
      other.enhanceImage == enhanceImage &&
      other.restyleImage == restyleImage &&
      other.restyleEffects == restyleEffects &&
      other.animeImage == animeImage &&
      other.animeEffects == animeEffects &&
      other.generateVideo == generateVideo &&
      other.removeBackground == removeBackground &&
      other.backgroundEffects == backgroundEffects &&
      other.removeOneTouch == removeOneTouch &&
      other.saveImagelarge == saveImagelarge &&
      other.skyImage == skyImage &&
      other.skyEffects == skyEffects &&
      other.restoreImage == restoreImage;
  }

  EndPoints copyWith({
    String? removeObject,
    String? scanObject,
    String? enhanceImage,
    String? restyleImage,
    String? restyleEffects,
    String? animeImage,
    String? animeEffects,
    String? generateVideo,
    String? removeBackground,
    String? backgroundEffects,
    String? removeOneTouch,
    String? saveImagelarge,
    String? skyImage,
    String? skyEffects,
    String? restoreImage,
  }) {
    return EndPoints(
      removeObject: removeObject ?? this.removeObject,
      scanObject: scanObject ?? this.scanObject,
      enhanceImage: enhanceImage ?? this.enhanceImage,
      restyleImage: restyleImage ?? this.restyleImage,
      restyleEffects: restyleEffects ?? this.restyleEffects,
      animeImage: animeImage ?? this.animeImage,
      animeEffects: animeEffects ?? this.animeEffects,
      generateVideo: generateVideo ?? this.generateVideo,
      removeBackground: removeBackground ?? this.removeBackground,
      backgroundEffects: backgroundEffects ?? this.backgroundEffects,
      removeOneTouch: removeOneTouch ?? this.removeOneTouch,
      saveImagelarge: saveImagelarge ?? this.saveImagelarge,
      skyImage: skyImage ?? this.skyImage,
      skyEffects: skyEffects ?? this.skyEffects,
      restoreImage: restoreImage ?? this.restoreImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'removeObject': removeObject,
      'scanObject': scanObject,
      'enhanceImage': enhanceImage,
      'restyleImage': restyleImage,
      'restyleEffects': restyleEffects,
      'animeImage': animeImage,
      'animeEffects': animeEffects,
      'generateVideo': generateVideo,
      'removeBackground': removeBackground,
      'backgroundEffects': backgroundEffects,
      'removeOneTouch': removeOneTouch,
      'saveImagelarge': saveImagelarge,
      'skyImage': skyImage,
      'skyEffects': skyEffects,
      'restoreImage': restoreImage,
    };
  }

  @override
  int get hashCode {
    return removeObject.hashCode ^
      scanObject.hashCode ^
      enhanceImage.hashCode ^
      restyleImage.hashCode ^
      restyleEffects.hashCode ^
      animeImage.hashCode ^
      animeEffects.hashCode ^
      generateVideo.hashCode ^
      removeBackground.hashCode ^
      backgroundEffects.hashCode ^
      removeOneTouch.hashCode ^
      saveImagelarge.hashCode ^
      skyImage.hashCode ^
      skyEffects.hashCode ^
      restoreImage.hashCode;
  }
}
