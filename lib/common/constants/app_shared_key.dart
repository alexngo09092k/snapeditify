part of '../constants.dart';

///DEFINE SHARED KEY
class AppSharedKey {
  static final AppSharedKey _instance = AppSharedKey._internal();
  static AppSharedKey get instance => _instance;

  factory AppSharedKey() => _instance;

  AppSharedKey._internal();

  String get remoteConfig => '${Configuration.instance.businessConfig.sharedKeyPrefix}remoteConfig';
  String get remoteConfigExpriedDate => '${Configuration.instance.businessConfig.sharedKeyPrefix}remoteConfigExpriedDate';
  String get themeMode => '${Configuration.instance.businessConfig.sharedKeyPrefix}themeMode';
  String get styles => '${Configuration.instance.businessConfig.sharedKeyPrefix}styles';
  String get animeStyles => '${Configuration.instance.businessConfig.sharedKeyPrefix}animeStyles';

  String get downloadCount => '${Configuration.instance.businessConfig.sharedKeyPrefix}downloadCount';
  String get strokeWidth => '${Configuration.instance.businessConfig.sharedKeyPrefix}strokeWidth';
  String get strokeColor => '${Configuration.instance.businessConfig.sharedKeyPrefix}strokeColor';
}
