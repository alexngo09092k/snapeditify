import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/models/config/app_platform.dart';

class MoreApp {
  final String name;
  final String logo;
  final Map<AppPlatform, String> links;

  MoreApp({
    required this.name,
    required this.logo,
    required this.links,
  });

  String? get link {
    if (CurrentPlatform.instance.isIos) {
      return links[AppPlatform.ios];
    }

    if (CurrentPlatform.instance.isHuawei) {
      return links[AppPlatform.huawei];
    }

    if (CurrentPlatform.instance.isAndroid) {
      return links[AppPlatform.android];
    }

    return null;
  }

  MoreApp copyWith({
    String? name,
    String? logo,
    Map<AppPlatform, String>? links,
  }) {
    return MoreApp(
      name: name ?? this.name,
      logo: logo ?? this.logo,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'logo': logo,
      'links': links.map((key, value) => MapEntry(key.name, value)),
    };
  }

  factory MoreApp.fromMap(Map<String, dynamic> map) {
    return MoreApp(
      name: map['name'] as String,
      logo: map['logo'] as String,
      links: map['links'].map<AppPlatform, String>(
        (key, value) => MapEntry(
          AppPlatform.values.firstWhere((element) => element.name == key),
          value.toString(),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoreApp.fromJson(String source) =>
      MoreApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MoreApp(name: $name, logo: $logo, links: $links)';

  @override
  bool operator ==(covariant MoreApp other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.logo == logo &&
        mapEquals(other.links, links);
  }

  @override
  int get hashCode => name.hashCode ^ logo.hashCode ^ links.hashCode;
}
