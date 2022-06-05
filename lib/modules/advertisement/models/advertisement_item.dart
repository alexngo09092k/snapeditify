import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:snapretouch/common/constants.dart';

import 'advertisement_extension.dart';

class AdvertisementItem {
  final AdvertisementType type;
  final AdvertisementProvider provider;
  final String androidId;
  final String iosId;
  final List<String> showOnScreens;
  final List<String> hideOnScreens;
  final int waitingTimeToDisplay;

  AdvertisementItem({
    this.type = AdvertisementType.banner,
    this.provider = AdvertisementProvider.google,
    this.androidId = '',
    this.iosId = '',
    this.showOnScreens = const <String>[],
    this.hideOnScreens = const <String>[],
    this.waitingTimeToDisplay = 1,
  });

  String get id => isAndroid ? androidId : iosId;

  AdvertisementItem copyWith({
    AdvertisementType? type,
    AdvertisementProvider? provider,
    String? androidId,
    String? iosId,
    List<String>? showOnScreens,
    List<String>? hideOnScreens,
    int? waitingTimeToDisplay,
  }) {
    return AdvertisementItem(
      type: type ?? this.type,
      provider: provider ?? this.provider,
      androidId: androidId ?? this.androidId,
      iosId: iosId ?? this.iosId,
      showOnScreens: showOnScreens ?? this.showOnScreens,
      hideOnScreens: hideOnScreens ?? this.hideOnScreens,
      waitingTimeToDisplay: waitingTimeToDisplay ?? this.waitingTimeToDisplay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'provider': provider.name,
      'androidId': androidId,
      'iosId': iosId,
      'showOnScreens': showOnScreens,
      'hideOnScreens': hideOnScreens,
      'waitingTimeToDisplay': waitingTimeToDisplay,
    };
  }

  factory AdvertisementItem.fromMap(Map<String, dynamic> map) {
    return AdvertisementItem(
      type: AdvertisementType.values.firstWhere((element) => describeEnum(element) == map['type']),
      provider: AdvertisementProvider.values.firstWhere((element) => describeEnum(element) == map['provider']),
      androidId: map['androidId'] ?? '',
      iosId: map['iosId'] ?? '',
      showOnScreens: List<String>.unmodifiable(map['showOnScreens'] ?? <String>[]),
      hideOnScreens: List<String>.unmodifiable(map['hideOnScreens'] ?? <String>[]),
      waitingTimeToDisplay:(map['waitingTimeToDisplay'] ?? 0).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvertisementItem.fromJson(String source) => AdvertisementItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdvertisementItem(type: $type, provider: $provider, androidId: $androidId, iosId: $iosId, showOnScreens: $showOnScreens, hideOnScreens: $hideOnScreens, waitingTimeToDisplay: $waitingTimeToDisplay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AdvertisementItem &&
      other.type == type &&
      other.provider == provider &&
      other.androidId == androidId &&
      other.iosId == iosId &&
      listEquals(other.showOnScreens, showOnScreens) &&
      listEquals(other.hideOnScreens, hideOnScreens) &&
      other.waitingTimeToDisplay == waitingTimeToDisplay;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      provider.hashCode ^
      androidId.hashCode ^
      iosId.hashCode ^
      showOnScreens.hashCode ^
      hideOnScreens.hashCode ^
      waitingTimeToDisplay.hashCode;
  }
}
