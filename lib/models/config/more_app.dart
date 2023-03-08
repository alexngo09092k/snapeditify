// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/models/config/app_platform.dart';

class MoreApp {
  final String name;
  final String logo;
  final String? banner;
  final String desc;
  final Map<AppPlatform, String> links;

  const MoreApp({
    required this.name,
    required this.logo,
    this.banner,
    required this.desc,
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
    String? banner,
    String? desc,
    Map<AppPlatform, String>? links,
  }) {
    return MoreApp(
      name: name ?? this.name,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      desc: desc ?? this.desc,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'logo': logo,
      'banner': banner,
      'desc': desc,
      'links': links,
    };
  }

  factory MoreApp.fromMap(Map<String, dynamic> map) {
    return MoreApp(
      name: map['name'] as String,
      logo: map['logo'] as String,
      banner: map['banner'],
      desc: map['desc'] as String,
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
  String toString() {
    return 'MoreApp(name: $name, logo: $logo, banner: $banner, desc: $desc, links: $links)';
  }

  @override
  bool operator ==(covariant MoreApp other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.logo == logo &&
        other.banner == banner &&
        other.desc == desc &&
        mapEquals(other.links, links);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        logo.hashCode ^
        banner.hashCode ^
        desc.hashCode ^
        links.hashCode;
  }
}
