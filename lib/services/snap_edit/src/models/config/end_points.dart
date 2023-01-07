// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EndPoints {
  /// Remove Objects
  /// Erase Image
  final String erase;
  final String erasePro;

  /// Erase Image With AI
  final String ai;
  final String aiPro;

  /// Enhance Image
  final String enhance;
  final String enhancePro;

  /// Restyle Image
  final String restyle;
  final String restylePro;

  /// Styles Image List
  final String styles;
  final String stylesPro;

  /// Anime Styles Image List
  final String animeStyles;
  final String animeStylesPro;

  /// Anime AI Image
  final String animeImageAI;
  final String animeImageAIPro;

  /// Anime AI Image
  final String animeVideoAI;
  final String animeVideoAIPro;

  EndPoints({
    required this.erase,
    required this.erasePro,
    required this.ai,
    required this.aiPro,
    required this.enhance,
    required this.enhancePro,
    required this.restyle,
    required this.restylePro,
    required this.styles,
    required this.stylesPro,
    required this.animeStyles,
    required this.animeStylesPro,
    required this.animeImageAI,
    required this.animeImageAIPro,
    required this.animeVideoAI,
    required this.animeVideoAIPro,
  });

  factory EndPoints.defaultValue() {
    return EndPoints(
      erase: "api/v6/erase",
      erasePro: "api/v6/erase",
      ai: "api/v6/ai_detection",
      aiPro: "api/v6/ai_detection",
      enhance: "api/v2/enhance",
      enhancePro: "api/v2/pro/enhance",
      restyle: "api/v1/restyle",
      restylePro: "api/v1/restyle",
      styles: "api/v1/restyle/styles",
      stylesPro: "api/v1/restyle/styles",
      animeStyles: "api/imagen/v1/styles",
      animeStylesPro: "api/imagen/v1/styles",
      animeImageAI: "api/imagen/v1",
      animeImageAIPro: "api/imagen/v1",
      animeVideoAI: "api/imagen/v1/video",
      animeVideoAIPro: "api/imagen/v1/video",
    );
  }

  EndPoints copyWith({
    String? erase,
    String? erasePro,
    String? ai,
    String? aiPro,
    String? enhance,
    String? enhancePro,
    String? restyle,
    String? restylePro,
    String? styles,
    String? stylesPro,
    String? animeStyles,
    String? animeStylesPro,
    String? animeImageAI,
    String? animeImageAIPro,
    String? animeVideoAI,
    String? animeVideoAIPro,
  }) {
    return EndPoints(
      erase: erase ?? this.erase,
      erasePro: erasePro ?? this.erasePro,
      ai: ai ?? this.ai,
      aiPro: aiPro ?? this.aiPro,
      enhance: enhance ?? this.enhance,
      enhancePro: enhancePro ?? this.enhancePro,
      restyle: restyle ?? this.restyle,
      restylePro: restylePro ?? this.restylePro,
      styles: styles ?? this.styles,
      stylesPro: stylesPro ?? this.stylesPro,
      animeStyles: animeStyles ?? this.animeStyles,
      animeStylesPro: animeStylesPro ?? this.animeStylesPro,
      animeImageAI: animeImageAI ?? this.animeImageAI,
      animeImageAIPro: animeImageAIPro ?? this.animeImageAIPro,
      animeVideoAI: animeVideoAI ?? this.animeVideoAI,
      animeVideoAIPro: animeVideoAIPro ?? this.animeVideoAIPro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'erase': erase,
      'erasePro': erasePro,
      'ai': ai,
      'aiPro': aiPro,
      'enhance': enhance,
      'enhancePro': enhancePro,
      'restyle': restyle,
      'restylePro': restylePro,
      'styles': styles,
      'stylesPro': stylesPro,
      'animeStyles': animeStyles,
      'animeStylesPro': animeStylesPro,
      'animeImageAI': animeImageAI,
      'animeImageAIPro': animeImageAIPro,
      'animeVideoAI': animeVideoAI,
      'animeVideoAIPro': animeVideoAIPro,
    };
  }

  factory EndPoints.fromMap(Map<String, dynamic> map) {
    return EndPoints(
      erase: map['erase'] as String,
      erasePro: map['erasePro'] as String,
      ai: map['ai'] as String,
      aiPro: map['aiPro'] as String,
      enhance: map['enhance'] as String,
      enhancePro: map['enhancePro'] as String,
      restyle: map['restyle'] as String,
      restylePro: map['restylePro'] as String,
      styles: map['styles'] as String,
      stylesPro: map['stylesPro'] as String,
      animeStyles: map['animeStyles'] as String,
      animeStylesPro: map['animeStylesPro'] as String,
      animeImageAI: map['animeImageAI'] as String,
      animeImageAIPro: map['animeImageAIPro'] as String,
      animeVideoAI: map['animeVideoAI'] as String,
      animeVideoAIPro: map['animeVideoAIPro'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EndPoints.fromJson(String source) => EndPoints.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EndPoints(erase: $erase, erasePro: $erasePro, ai: $ai, aiPro: $aiPro, enhance: $enhance, enhancePro: $enhancePro, restyle: $restyle, restylePro: $restylePro, styles: $styles, stylesPro: $stylesPro, animeStyles: $animeStyles, animeStylesPro: $animeStylesPro, animeImageAI: $animeImageAI, animeImageAIPro: $animeImageAIPro, animeVideoAI: $animeVideoAI, animeVideoAIPro: $animeVideoAIPro)';
  }

  @override
  bool operator ==(covariant EndPoints other) {
    if (identical(this, other)) return true;

    return other.erase == erase &&
        other.erasePro == erasePro &&
        other.ai == ai &&
        other.aiPro == aiPro &&
        other.enhance == enhance &&
        other.enhancePro == enhancePro &&
        other.restyle == restyle &&
        other.restylePro == restylePro &&
        other.styles == styles &&
        other.stylesPro == stylesPro &&
        other.animeStyles == animeStyles &&
        other.animeStylesPro == animeStylesPro &&
        other.animeImageAI == animeImageAI &&
        other.animeImageAIPro == animeImageAIPro &&
        other.animeVideoAI == animeVideoAI &&
        other.animeVideoAIPro == animeVideoAIPro;
  }

  @override
  int get hashCode {
    return erase.hashCode ^
        erasePro.hashCode ^
        ai.hashCode ^
        aiPro.hashCode ^
        enhance.hashCode ^
        enhancePro.hashCode ^
        restyle.hashCode ^
        restylePro.hashCode ^
        styles.hashCode ^
        stylesPro.hashCode ^
        animeStyles.hashCode ^
        animeStylesPro.hashCode ^
        animeImageAI.hashCode ^
        animeImageAIPro.hashCode ^
        animeVideoAI.hashCode ^
        animeVideoAIPro.hashCode;
  }
}
