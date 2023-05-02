// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'background.dart';

class BackgroundResponse {
  final List<Background> backgrounds;

  const BackgroundResponse({
    required this.backgrounds,
  });

  BackgroundResponse copyWith({
    List<Background>? backgrounds,
  }) {
    return BackgroundResponse(
      backgrounds: backgrounds ?? this.backgrounds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backgrounds': backgrounds.map((x) => x.toMap()).toList(),
    };
  }

  factory BackgroundResponse.fromMap(Map<String, dynamic> map) {
    return BackgroundResponse(
      backgrounds: List<Background>.from((map['backgrounds']).map<Background>((x) => Background.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BackgroundResponse.fromJson(String source) => BackgroundResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BackgroundResponse(backgrounds: $backgrounds)';

  @override
  bool operator ==(covariant BackgroundResponse other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.backgrounds, backgrounds);
  }

  @override
  int get hashCode => backgrounds.hashCode;
}
