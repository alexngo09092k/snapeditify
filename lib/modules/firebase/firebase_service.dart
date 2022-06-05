import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:gms_check/gms_check.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/modules/firebase/base_firebase_services.dart';
import 'package:snapretouch/modules/firebase/firebase_analytics_service.dart';
import 'package:snapretouch/modules/firebase/models/firebase_config.dart';

class FirebaseServices extends BaseFirebaseServices {
  static final FirebaseServices _instance = FirebaseServices._internal();

  factory FirebaseServices() => _instance;

  final firebaseAnalyticsService = FirebaseAnalyticsService();

  FirebaseServices._internal();

  bool _isEnabled = false;

  @override
  bool get isEnabled => _isEnabled;

  @override
  Future<void> init(FirebaseConfig config,{String? name, FirebaseOptions? options}) async {
    _isEnabled =  config.enableFirebase;
    printLog(config);
    var startTime = DateTime.now();
    await Firebase.initializeApp(name: name, options: options);

    if (!kIsWeb && config.enableRemoteConfigFirebase) {
      _remoteConfig = FirebaseRemoteConfig.instance;
      await _remoteConfig!.fetch();
      await _remoteConfig!.activate();
    }

    /// Require Play Services
    const message = '[FirebaseServices] Init successfully';
    if (GmsCheck().isGmsAvailable) {
      _messaging = FirebaseMessaging.instance;
      printLog(message, startTime);
    } else {
      printLog('$message (without Google Play Services)', startTime);
    }
  }

  /// Firebase Remote Config
  FirebaseRemoteConfig? _remoteConfig;

  FirebaseRemoteConfig? get remoteConfig => _remoteConfig;

  FirebaseMessaging? _messaging;

  FirebaseMessaging? get messaging => _messaging;

  @override
  Future<String?> getMessagingToken() async {
    return await messaging!.getToken();
  }

  @override
  getCloudMessaging() {
    throw UnimplementedError();
  }
}
