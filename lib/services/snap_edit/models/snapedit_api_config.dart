// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:fluttering/fluttering.dart';

class SnapEditConfig {
  final String baseUrl;
  final EndPoints endPoints;
  final Headers headers;

  SnapEditConfig({
    this.baseUrl = 'https://be-prod-1.snapedit.app',
    this.endPoints = const EndPoints(ai: '/ai_detection/v4', erase: '/erase/v4'),
    this.headers = const Headers(
      ios: {
        'Host': 'be-prod-1.snapedit.app',
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
        'accept': '*/*',
        'content-type': 'application/json',
        'user-agent': 'SnapEdit/1.2.3 (com.sfun.snapedit; build:37; iOS 15.1.1) Alamofire/5.5.0',
        'accept-language': 'vi-VN;q=1.0',
      },
      android: {
        'Host': 'be-prod-1.snapedit.app',
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
        'accept': '*/*',
        'content-type': 'application/json',
        'user-agent': 'SnapEdit/1.2.3 (com.sfun.snapedit; build:37; iOS 15.1.1) Alamofire/5.5.0',
        'accept-language': 'vi-VN;q=1.0',
      },
    ),
  });

  Map<String, String> get currentHeaders => CurrentPlatform.instance.isIos ? headers.ios : headers.android;

  SnapEditConfig copyWith({
    String? baseUrl,
    EndPoints? endPoints,
    Headers? headers,
  }) {
    return SnapEditConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      endPoints: endPoints ?? this.endPoints,
      headers: headers ?? this.headers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseUrl': baseUrl,
      'endPoints': endPoints.toMap(),
      'headers': headers.toMap(),
    };
  }

  factory SnapEditConfig.fromMap(Map<String, dynamic> map) {
    return SnapEditConfig(
      baseUrl: map['baseUrl'] ?? '',
      endPoints: EndPoints.fromMap(map['endPoints']),
      headers: Headers.fromMap(map['headers']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SnapEditConfig.fromJson(String source) => SnapEditConfig.fromMap(json.decode(source));

  @override
  String toString() => 'SnapEditConfig(baseUrl: $baseUrl, endPoints: $endPoints, headers: $headers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SnapEditConfig && other.baseUrl == baseUrl && other.endPoints == endPoints && other.headers == headers;
  }

  @override
  int get hashCode => baseUrl.hashCode ^ endPoints.hashCode ^ headers.hashCode;
}

class EndPoints {
  final String erase;
  final String ai;

  const EndPoints({
    required this.erase,
    required this.ai,
  });

  EndPoints copyWith({
    String? erase,
    String? ai,
  }) {
    return EndPoints(
      erase: erase ?? this.erase,
      ai: ai ?? this.ai,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'erase': erase,
      'ai': ai,
    };
  }

  factory EndPoints.fromMap(Map<String, dynamic> map) {
    return EndPoints(
      erase: map['erase'] ?? '',
      ai: map['ai'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EndPoints.fromJson(String source) => EndPoints.fromMap(json.decode(source));

  @override
  String toString() => 'EndPoints(erase: $erase, ai: $ai)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EndPoints && other.erase == erase && other.ai == ai;
  }

  @override
  int get hashCode => erase.hashCode ^ ai.hashCode;
}

class Headers {
  final Map<String, String> ios;
  final Map<String, String> android;
  const Headers({
    required this.ios,
    required this.android,
  });

  Headers copyWith({
    Map<String, String>? ios,
    Map<String, String>? android,
  }) {
    return Headers(
      ios: ios ?? this.ios,
      android: android ?? this.android,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ios': ios,
      'android': android,
    };
  }

  factory Headers.fromMap(Map<String, dynamic> map) {
    return Headers(
      ios: Map<String, String>.from(map['ios']),
      android: Map<String, String>.from(map['android']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Headers.fromJson(String source) => Headers.fromMap(json.decode(source));

  @override
  String toString() => 'Headers(ios: $ios, android: $android)';

  @override
  int get hashCode => ios.hashCode ^ android.hashCode;

  @override
  bool operator ==(Object other) {
    return super == other;
  }



}
