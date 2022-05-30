import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:snapedit/app.dart';
import 'package:snapedit/common/app_config.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/env.dart';
import 'package:snapedit/init_app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // printLog('Handling a background message ${message.messageId}');
}

void main() async {
  runZonedGuarded(() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      AppConfig.setConfig(enviroment);

      await initApp();

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      runApp(const App());
    } catch (error) {
      printLog(error);
    }
  }, (e, stack) {
    printLog(e);
    printLog(stack.toString());
  });
}
