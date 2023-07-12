// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';

import 'app_platform.dart';

class UpdateApp {
  final String version;
  final bool required;
  final Map<AppPlatform, String> links;

  UpdateApp({
    required this.version,
    required this.required,
    required this.links,
  });

  String? get link {
    if (CurrentPlatform.instance.isIos) {
      return links[AppPlatform.ios];
    }

    if(CurrentPlatform.instance.isHuawei) {
      return links[AppPlatform.huawei];
    }

    if (CurrentPlatform.instance.isAndroid) {
      return links[AppPlatform.android];
    }

    return null;
  }

  UpdateApp copyWith({
    String? version,
    bool? required,
    Map<AppPlatform, String>? links,
  }) {
    return UpdateApp(
      version: version ?? this.version,
      required: required ?? this.required,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'required': required,
      'links': links.map((key, value) => MapEntry(key.name, value)),
    };
  }

  factory UpdateApp.fromMap(Map<String, dynamic> map) {
    return UpdateApp(
      version: map['version'] as String,
      required: map['required'] as bool,
      links: map['links'].map<AppPlatform, String>(
        (key, value) => MapEntry(
          AppPlatform.values.firstWhere((element) => element.name == key),
          value.toString(),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateApp.fromJson(String source) => UpdateApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UpdateApp(version: $version, required: $required, links: $links)';

  @override
  bool operator ==(covariant UpdateApp other) {
    if (identical(this, other)) return true;
  
    return 
      other.version == version &&
      other.required == required &&
      mapEquals(other.links, links);
  }

  @override
  int get hashCode => version.hashCode ^ required.hashCode ^ links.hashCode;
}
