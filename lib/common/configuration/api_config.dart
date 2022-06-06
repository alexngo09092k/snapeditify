part of '../configuration.dart';

class ApiConfig {
  final String url;
  final _EndPoints endPoints;
  final _Headers headers;

  ApiConfig({
    required this.url,
    this.endPoints = const _EndPoints(ai: '', erase: ''),
    this.headers = const _Headers(ios: {}, android: {}),
  });

  ApiConfig copyWith({
    String? url,
    _EndPoints? endPoints,
    _Headers? headers,
  }) {
    return ApiConfig(
      url: url ?? this.url,
      endPoints: endPoints ?? this.endPoints,
      headers: headers ?? this.headers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'endPoints': endPoints.toMap(),
      'headers': headers.toMap(),
    };
  }

  factory ApiConfig.fromMap(Map<String, dynamic> map) {
    return ApiConfig(
      url: map['url'] ?? '',
      endPoints: _EndPoints.fromMap(map['endPoints']),
      headers: _Headers.fromMap(map['headers']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiConfig.fromJson(String source) =>
      ApiConfig.fromMap(json.decode(source));

  @override
  String toString() =>
      'ApiConfig(url: $url, endPoints: $endPoints, headers: $headers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiConfig &&
        other.url == url &&
        other.endPoints == endPoints &&
        other.headers == headers;
  }

  @override
  int get hashCode => url.hashCode ^ endPoints.hashCode ^ headers.hashCode;
}

class _EndPoints {
  final String erase;
  final String ai;

  const _EndPoints({
    required this.erase,
    required this.ai,
  });

  _EndPoints copyWith({
    String? erase,
    String? ai,
  }) {
    return _EndPoints(
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

  factory _EndPoints.fromMap(Map<String, dynamic> map) {
    return _EndPoints(
      erase: map['erase'] ?? '',
      ai: map['ai'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory _EndPoints.fromJson(String source) =>
      _EndPoints.fromMap(json.decode(source));

  @override
  String toString() => 'EndPoints(erase: $erase, ai: $ai)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _EndPoints && other.erase == erase && other.ai == ai;
  }

  @override
  int get hashCode => erase.hashCode ^ ai.hashCode;
}

class _Headers {
  final Map<String, String> ios;
  final Map<String, String> android;
  const _Headers({
    required this.ios,
    required this.android,
  });

  _Headers copyWith({
    Map<String, String>? ios,
    Map<String, String>? android,
  }) {
    return _Headers(
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

  factory _Headers.fromMap(Map<String, dynamic> map) {
    return _Headers(
      ios: Map<String, String>.from(map['ios']),
      android: Map<String, String>.from(map['android']),
    );
  }

  String toJson() => json.encode(toMap());

  factory _Headers.fromJson(String source) => _Headers.fromMap(json.decode(source));

  @override
  String toString() => '_Headers(ios: $ios, android: $android)';

  @override
  int get hashCode => ios.hashCode ^ android.hashCode;
}
