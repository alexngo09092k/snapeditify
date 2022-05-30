part of '../constants.dart';

bool get kIsWeb => foundation.kIsWeb;
bool get isIos => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
bool get isAndroid => foundation.defaultTargetPlatform == foundation.TargetPlatform.android;
bool get isMacOS => foundation.defaultTargetPlatform == foundation.TargetPlatform.macOS;
final bool isMobile =isIos || isAndroid;
