import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RestyleConfig {
  /// Free dimension
  final int freeDimension;

  /// Premium dimension
  final int premiumDimension;

  RestyleConfig({
    required this.freeDimension,
    required this.premiumDimension,
  });

  factory RestyleConfig.defaultValue() {
    return RestyleConfig(
      freeDimension: 1920,
      premiumDimension: 3000,
    );
  }

  RestyleConfig copyWith({
    int? freeDimension,
    int? premiumDimension,
  }) {
    return RestyleConfig(
      freeDimension: freeDimension ?? this.freeDimension,
      premiumDimension: premiumDimension ?? this.premiumDimension,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'freeDimension': freeDimension,
      'premiumDimension': premiumDimension,
    };
  }

  factory RestyleConfig.fromMap(Map<String, dynamic> map) {
    return RestyleConfig.defaultValue().copyWith(
      freeDimension: map['freeDimension'],
      premiumDimension: map['premiumDimension'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RestyleConfig.fromJson(String source) => RestyleConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RestyleConfig(freeDimension: $freeDimension, premiumDimension: $premiumDimension)';

  @override
  bool operator ==(covariant RestyleConfig other) {
    if (identical(this, other)) return true;

    return other.freeDimension == freeDimension && other.premiumDimension == premiumDimension;
  }

  @override
  int get hashCode => freeDimension.hashCode ^ premiumDimension.hashCode;
}
