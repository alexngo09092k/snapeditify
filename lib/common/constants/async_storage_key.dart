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

  String get restyleEffects => '${prefix}restyleEffects';
  String get animeEffects => '${prefix}animeEffects';
  String get skyEffects => '${prefix}skyEffects';
  String get backgroundEffects => '${prefix}backgroundEffects';

  String get brushGuide => '${prefix}brushGuide';
  String get autoAIGuide => '${prefix}autoAIGuide';
  String get enhanceGuide => '${prefix}enhanceGuide';

  String get saveCount => '${prefix}saveCount';

  String get strokeWidth => '${prefix}strokeWidth';
  String get strokeColor => '${prefix}strokeColor';
}
