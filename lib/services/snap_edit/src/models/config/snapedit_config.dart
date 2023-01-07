// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:snapedit/services/snap_edit/src/models/config/end_points.dart';
import 'package:snapedit/services/snap_edit/src/models/config/enhance_config.dart';
import 'package:snapedit/services/snap_edit/src/models/config/remove_object_config.dart';
import 'package:snapedit/services/snap_edit/src/models/config/restyle_config.dart';

class SnapEditConfig {
  final String baseUrl;

  final String apiKey;

  final String version;

  final EndPoints endPoints;

  final EnhanceConfig enhance;

  final RestyleConfig restyle;

  final RemoveObjectConfig removeObject;

  final bool waterMark;

  final int maxFreeDownloadCount;

  SnapEditConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.version,
    required this.endPoints,
    required this.enhance,
    required this.restyle,
    required this.removeObject,
    required this.waterMark,
    required this.maxFreeDownloadCount,
    
  });

  factory SnapEditConfig.defaultValue() {
    return SnapEditConfig(
      baseUrl: "https://be-prod-1.snapedit.app/",
      apiKey: "s2svtF6qSCwBCI0Xjm4MvY0fBGVrtoUCbidhNmkvrJA=",
      version: "",
      waterMark: false,
      maxFreeDownloadCount: 100,
      endPoints: EndPoints.defaultValue(),
      enhance: EnhanceConfig.defaultValue(),
      restyle: RestyleConfig.defaultValue(),
      removeObject: RemoveObjectConfig.defaultValue(),
    );
  }

  SnapEditConfig copyWith({
    String? baseUrl,
    String? apiKey,
    String? version,
    EndPoints? endPoints,
    EnhanceConfig? enhance,
    RestyleConfig? restyle,
    RemoveObjectConfig? removeObject,
    bool? waterMark,
    int? maxFreeDownloadCount,
  }) {
    return SnapEditConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      apiKey: apiKey ?? this.apiKey,
      version: version ?? this.version,
      endPoints: endPoints ?? this.endPoints,
      enhance: enhance ?? this.enhance,
      restyle: restyle ?? this.restyle,
      removeObject: removeObject ?? this.removeObject,
      waterMark: waterMark ?? this.waterMark,
      maxFreeDownloadCount: maxFreeDownloadCount ?? this.maxFreeDownloadCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseUrl': baseUrl,
      'apiKey': apiKey,
      'version': version,
      'endPoints': endPoints.toMap(),
      'enhance': enhance.toMap(),
      'restyle': restyle.toMap(),
      'removeObject': removeObject.toMap(),
      'waterMark': waterMark,
      'maxFreeDownloadCount': maxFreeDownloadCount,
    };
  }

  factory SnapEditConfig.fromMap(Map<String, dynamic> map) {
    return SnapEditConfig.defaultValue().copyWith(
      baseUrl: map['baseUrl'],
      apiKey: map['apiKey'],
      version: map['version'],
      endPoints: EndPoints.fromMap(map['endPoints']),
      enhance: EnhanceConfig.fromMap(map['enhance']),
      restyle: RestyleConfig.fromMap(map['restyle']),
      removeObject: RemoveObjectConfig.fromMap(map['removeObject']),
      waterMark: map['waterMark'],
      maxFreeDownloadCount: map['maxFreeDownloadCount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SnapEditConfig.fromJson(String source) => SnapEditConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SnapEditConfig(baseUrl: $baseUrl, apiKey: $apiKey, version: $version, endPoints: $endPoints, enhance: $enhance, restyle: $restyle, removeObject: $removeObject, waterMark: $waterMark, maxFreeDownloadCount: $maxFreeDownloadCount)';
  }

  @override
  bool operator ==(covariant SnapEditConfig other) {
    if (identical(this, other)) return true;

    return other.baseUrl == baseUrl &&
        other.apiKey == apiKey &&
        other.version == version &&
        other.endPoints == endPoints &&
        other.enhance == enhance &&
        other.restyle == restyle &&
        other.removeObject == removeObject &&
        other.waterMark == waterMark &&
        other.maxFreeDownloadCount == maxFreeDownloadCount;
  }

  @override
  int get hashCode {
    return baseUrl.hashCode ^
        apiKey.hashCode ^
        version.hashCode ^
        endPoints.hashCode ^
        enhance.hashCode ^
        restyle.hashCode ^
        removeObject.hashCode ^
        waterMark.hashCode ^
        maxFreeDownloadCount.hashCode;
  }
}

extension HeaderBuilders on SnapEditConfig {
  Map<String, String> get headers => {
        "User-Agent": "SnapEdit/$version (com.sfun.snapedit; build:155; iOS 15.6.1) Alamofire/5.6.2",
        "Authorization": "Bearer $jwt",
      };
}

extension JWTBuilders on SnapEditConfig {
  String get jwt => _buildJWT();

  String _buildJWT() {
    return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2ZXJzaW9uIjoiMy4xLjAiLCJleHAiOjE3Njk2MjI0MDEsInN1YiI6Imlnbm9yZSIsInBsYXRmb3JtIjoiYW5kcm9pZCJ9.OufJuEzKvN2RVCw-Ofy1oY6d9oRuOnM_Vxmt6aqLWAk";
  }
}
