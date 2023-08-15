import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_iap/iap/iap.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';
import 'package:qr_scanner/app.dart';
import 'package:qr_scanner/common/configuration.dart';
import 'package:qr_scanner/enviroment.dart';
import 'package:qr_scanner/firebase_options.dart';
import 'package:qr_scanner/models/config/bussiness_config/bussiness_config.dart';
import 'package:qr_scanner/providers/app_theme_provider.dart';
import 'package:qr_scanner/providers/generate_provider.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:qr_scanner/providers/home_provider.dart';
import 'package:qr_scanner/providers/scanner_provider.dart';

void main() {
  AwesomeApp(
    app: const App(),
    inAppReview: const InAppReviewConfig(enable: false),
    providers: [
      AwesomeAdvertisement.instance,
      AwesomeIAP.instance,
      AwesomeRemoteConfig.instance,
      AppThemeProvider(themeMode: ThemeMode.light, locale: const Locale('en')),
      HistoryProvider.instance,
    ],
    lazyProviders: [
      () => HomeProvider(),
      () => ScannerProvider(),
      () => GenerateProvider(),
    ],
    onWillInitialize: () async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await Configuration.instance.loadLocalConfig(enviroment);

      AwesomeRemoteConfig.instance.initial(Configuration.instance.remoteConfig);

      return true;
    },
    onDidInitialize: () async {
      await Configuration.instance.loadRemoteConfig();

      Debug.debugMode = Configuration.instance.business.appMode == AppMode.debug;

      AwesomeAdvertisement.instance.initial(Configuration.instance.advertisement);
      AwesomeIAP.instance.initial(Configuration.instance.iap);

      return true;
    },
  ).run();
}
