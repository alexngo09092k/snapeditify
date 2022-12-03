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
  });

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
    );
  }

  String toJson() => json.encode(toMap());

  factory EndPoints.fromJson(String source) => EndPoints.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EndPoints(erase: $erase, erasePro: $erasePro, ai: $ai, aiPro: $aiPro, enhance: $enhance, enhancePro: $enhancePro, restyle: $restyle, restylePro: $restylePro, styles: $styles, stylesPro: $stylesPro)';
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
        other.stylesPro == stylesPro;
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
        stylesPro.hashCode;
  }
}
