import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:snapretouch/app.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/env.dart';
import 'package:snapretouch/init_app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   printLog('Handling a background message ${message.messageId}');
}

void main() {
  runZonedGuarded(() async {
    try {
      printLog('START APP');

      WidgetsFlutterBinding.ensureInitialized();

      await Cofiguration.setConfig(enviroment);

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      await initApp();

      runApp(const App());
    } catch (error) {
      printLog(error);
    }
  }, (e, stack) {
    printLog(e);
    printLog(stack.toString());
  });
}
