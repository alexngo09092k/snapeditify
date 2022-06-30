import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'advertisement_item.dart';

class AdvertisementConfig {
  final List<AdvertisementItem> ads;
  final List<String> googleTestingId;
  final bool enable;
  final String adMobAppIdAndroid;
  final String adMobAppIdIos;

  const AdvertisementConfig({
    this.ads = const <AdvertisementItem>[],
    this.googleTestingId = const <String>[],
    this.enable = false,
    this.adMobAppIdAndroid = '',
    this.adMobAppIdIos = '',
  });

  AdvertisementConfig copyWith({
    List<AdvertisementItem>? ads,
    String? facebookTestingId,
    List<String>? googleTestingId,
    bool? enable,
    String? adMobAppIdAndroid,
    String? adMobAppIdIos,
  }) {
    return AdvertisementConfig(
      ads: ads ?? this.ads,
      googleTestingId: googleTestingId ?? this.googleTestingId,
      enable: enable ?? this.enable,
      adMobAppIdAndroid: adMobAppIdAndroid ?? this.adMobAppIdAndroid,
      adMobAppIdIos: adMobAppIdIos ?? this.adMobAppIdIos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ads': ads.map((x) => x.toMap()).toList(),
      'googleTestingId': googleTestingId,
      'enable': enable,
      'adMobAppIdAndroid': adMobAppIdAndroid,
      'adMobAppIdIos': adMobAppIdIos,
    };
  }

  factory AdvertisementConfig.fromMap(Map<String, dynamic> map) {
    return AdvertisementConfig(
      ads: List<AdvertisementItem>.from(map['ads']?.map((x) => AdvertisementItem.fromMap(x))),
      googleTestingId: List<String>.from(map['googleTestingId']),
      enable: map['enable'] ?? false,
      adMobAppIdAndroid: map['adMobAppIdAndroid'] ?? '',
      adMobAppIdIos: map['adMobAppIdIos'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvertisementConfig.fromJson(String source) =>
      AdvertisementConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdvertisementConfig(ads: $ads, googleTestingId: $googleTestingId, enable: $enable, adMobAppIdAndroid: $adMobAppIdAndroid, adMobAppIdIos: $adMobAppIdIos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdvertisementConfig &&
        listEquals(other.ads, ads) &&
        listEquals(other.googleTestingId, googleTestingId) &&
        other.enable == enable &&
        other.adMobAppIdAndroid == adMobAppIdAndroid &&
        other.adMobAppIdIos == adMobAppIdIos;
  }

  @override
  int get hashCode {
    return ads.hashCode ^
        googleTestingId.hashCode ^
        enable.hashCode ^
        adMobAppIdAndroid.hashCode ^
        adMobAppIdIos.hashCode;
  }
}
