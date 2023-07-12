part of '../constants.dart';

///DEFINE SHARED KEY
class AsyncStorageKey {
  static final AsyncStorageKey _instance = AsyncStorageKey._internal();
  static AsyncStorageKey get instance => _instance;

  factory AsyncStorageKey() => _instance;

  AsyncStorageKey._internal();

  String get prefix => Configuration.instance.business.prefix;

  String get remoteConfig => '${prefix}remoteConfig';
  String get remoteConfigExpriedDate => '${prefix}remoteConfigExpriedDate';
  String get themeMode => '${prefix}themeMode';

  String get scannerSettings => '${prefix}scannerSettings';
  String get scanHistory => '${prefix}scanHistory';
  String get generateHistory => '${prefix}generateHistory';
}
