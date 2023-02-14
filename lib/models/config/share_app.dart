import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'app_platform.dart';

class ShareApp {
  final String message;
  final Map<AppPlatform, String> links;

  ShareApp({
    required this.message,
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

  ShareApp copyWith({
    String? message,
    Map<AppPlatform, String>? links,
  }) {
    return ShareApp(
      message: message ?? this.message,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'links': links.map((key, value) => MapEntry(key.name, value)),
    };
  }

  factory ShareApp.fromMap(Map<String, dynamic> map) {
    return ShareApp(
      message: map['message'] as String,
      links: map['links'].map<AppPlatform, String>(
        (key, value) => MapEntry(
          AppPlatform.values.firstWhere((element) => element.name == key),
          value.toString(),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShareApp.fromJson(String source) => ShareApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShareApp(message: $message, links: $links)';

  @override
  bool operator ==(covariant ShareApp other) {
    if (identical(this, other)) return true;

    return other.message == message && mapEquals(other.links, links);
  }

  @override
  int get hashCode => message.hashCode ^ links.hashCode;
}
