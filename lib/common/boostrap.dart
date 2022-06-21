import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gms_check/gms_check.dart';
import 'package:snapretouch/common/app_cache.dart';
import 'package:snapretouch/common/app_lifecycle.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/services/services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printLog('Handling a background message ${message.messageId}');
}

bootstrap(
  Widget app, {
  Future<void> Function()? onRun,
  Function(Object?)? onError,
}) {
  runZonedGuarded(() async {
    printLog('start app');
    try {
      WidgetsFlutterBinding.ensureInitialized();
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      openApp();

      if (isMobile) {
        AppCache.instance.initial();

        await GmsCheck().checkGmsAvailability(enableLog: kDebugMode);

        /// Init Firebase settings due to version 0.5.0+ requires to.
        /// Use await to prevent any usage until the initialization is completed.
        await Services().firebase.init(
              Cofiguration.firebaseConfig,
              // options: DefaultFirebaseOptions.currentPlatform,
            );

        await Cofiguration.instance.loadRemoteConfig();

        Services().advertisement.init(Cofiguration.adConfig);
      }

      if (onRun != null) await onRun();

      runApp(app);
    } catch (error) {
      printLog(error);
      if (onError != null) onError(error);
    }
  }, (e, stack) {
    printLog(e);
    printLog(stack);
    if (onError != null) onError(e);
  });
}
