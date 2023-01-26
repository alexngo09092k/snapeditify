part of '../constants.dart';

///DEFINE SHARED KEY
class AppSharedKey {
  static final AppSharedKey _instance = AppSharedKey._internal();
  static AppSharedKey get instance => _instance;

  factory AppSharedKey() => _instance;

  AppSharedKey._internal();

  String get remoteConfig => '${Configuration.instance.business.sharedKeyPrefix}remoteConfig';
  String get remoteConfigExpriedDate => '${Configuration.instance.business.sharedKeyPrefix}remoteConfigExpriedDate';
  String get themeMode => '${Configuration.instance.business.sharedKeyPrefix}themeMode';
  String get styles => '${Configuration.instance.business.sharedKeyPrefix}styles';
  String get animeStyles => '${Configuration.instance.business.sharedKeyPrefix}animeStyles';

  String get saveCount => '${Configuration.instance.business.sharedKeyPrefix}saveCount';
  String get strokeWidth => '${Configuration.instance.business.sharedKeyPrefix}strokeWidth';
  String get strokeColor => '${Configuration.instance.business.sharedKeyPrefix}strokeColor';
}
