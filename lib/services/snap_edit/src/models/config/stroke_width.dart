import 'dart:convert';
import 'package:flutter/material.dart';

class StrokeWidth {
  final int min;
  final int max;
  final int init;
  final Color color;

  const StrokeWidth({
    required this.min,
    required this.max,
    required this.init,
    required this.color,
  });

  factory StrokeWidth.defaultValue() {
    return StrokeWidth(
      min: 1,
      max: 100,
      init: 20,
      color: Colors.red.withOpacity(0.5),
    );
  }

  StrokeWidth copyWith({
    int? min,
    int? max,
    int? init,
    Color? color,
  }) {
    return StrokeWidth(
      min: min ?? this.min,
      max: max ?? this.max,
      init: init ?? this.init,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'min': min,
      'max': max,
      'init': init,
      'color': [color.red, color.green, color.blue, color.opacity],
    };
  }

  factory StrokeWidth.fromMap(Map<String, dynamic> map) {
    return StrokeWidth.defaultValue().copyWith(
      min: map['min'],
      max: map['max'],
      init: map['init'],
      color: map['color'] != null
          ? Color.fromRGBO(
              (map['color'][0] ?? 255).toInt(),
              (map['color'][1] ?? 255).toInt(),
              (map['color'][2] ?? 255).toInt(),
              (map['color'][3] ?? 0.5),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StrokeWidth.fromJson(String source) => StrokeWidth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StrokeWidth(min: $min, max: $max, init: $init, color: $color)';
  }

  @override
  bool operator ==(covariant StrokeWidth other) {
    if (identical(this, other)) return true;

    return other.min == min && other.max == max && other.init == init && other.color == color;
  }

  @override
  int get hashCode {
    return min.hashCode ^ max.hashCode ^ init.hashCode ^ color.hashCode;
  }
}
