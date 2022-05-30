import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:snapedit/app.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/env.dart';
import 'package:snapedit/init_app.dart';

void main() {
  runZonedGuarded(() async {
    try {
      printLog('START APP');

      WidgetsFlutterBinding.ensureInitialized();

      await Cofiguration.setConfig(enviroment);

      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        printLog('Handling a background message ${message.messageId}');
      });

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
