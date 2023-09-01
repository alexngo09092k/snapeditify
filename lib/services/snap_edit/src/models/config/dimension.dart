import 'dart:convert';

class Dimension {
  final int high;
  final int standard;
  final int pro;

  Dimension({
    required this.high,
    required this.standard,
    required this.pro,
  });

  factory Dimension.defaultValue() {
    return Dimension(
      high: 1920,
      standard: 1920,
      pro: 3000,
    );
  }

  Dimension copyWith({
    int? high,
    int? standard,
    int? pro,
  }) {
    return Dimension(
      high: high ?? this.high,
      standard: standard ?? this.standard,
      pro: pro ?? this.pro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'high': high,
      'standard': standard,
      'pro': pro,
    };
  }

  factory Dimension.fromMap(Map<String, dynamic> map) {
    return Dimension.defaultValue().copyWith(
      high: map['high'],
      standard: map['standard'],
      pro: map['pro'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dimension.fromJson(String source) => Dimension.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Dimension(high: $high, standard: $standard, pro: $pro)';

  @override
  bool operator ==(covariant Dimension other) {
    if (identical(this, other)) return true;

    return other.high == high && other.standard == standard && other.pro == pro;
  }

  @override
  int get hashCode => high.hashCode ^ standard.hashCode ^ pro.hashCode;
}
