part of '../constants.dart';

///DEFINE SHARED KEY
class AppSharedKey {
  static final AppSharedKey _instance = AppSharedKey._internal();
  static AppSharedKey get instance => _instance;

  factory AppSharedKey() => _instance;

  AppSharedKey._internal();

  String get remoteConfig => '${Configuration.instance.appConfig.sharedKeyPrefix}remoteConfig';
  String get remoteConfigExpriedDate => '${Configuration.instance.appConfig.sharedKeyPrefix}remoteConfigExpriedDate';
  String get image => '${Configuration.instance.appConfig.sharedKeyPrefix}IMAGE';
  String get freestyleStrokeWidth => '${Configuration.instance.appConfig.sharedKeyPrefix}FREE_STYLE_STROKE_WIDTH';
  String get themeMode => '${Configuration.instance.appConfig.sharedKeyPrefix}themeMode';
}
