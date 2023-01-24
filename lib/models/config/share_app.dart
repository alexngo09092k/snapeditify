import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

enum ShareAppPlatform {
  android,
  huawei,
  ios,
}

class ShareApp {
  final String message;
  final Map<ShareAppPlatform, String> links;

  ShareApp({
    required this.message,
    required this.links,
  });

  String? get link {
    if (CurrentPlatform.instance.isIos) {
      return links[ShareAppPlatform.ios];
    }

    if (CurrentPlatform.instance.isAndroid) {
      if (DeviceInfo.instance.android != null && (DeviceInfo.instance.android!.manufacturer ?? '').toUpperCase() == 'HUAWEI') {
        return links[ShareAppPlatform.huawei];
      }

      return links[ShareAppPlatform.android];
    }

    return null;
  }

  ShareApp copyWith({
    String? message,
    Map<ShareAppPlatform, String>? links,
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
      links: map['links'].map<ShareAppPlatform, String>(
        (key, value) => MapEntry(
          ShareAppPlatform.values.firstWhere((element) => element.name == key),
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
