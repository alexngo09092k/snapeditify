
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_iap/iap/index.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:snapcut/app.dart';
import 'package:snapcut/common/configuration.dart';
import 'package:snapcut/enviroment.dart';
import 'package:snapcut/firebase_options.dart';
import 'package:snapcut/models/config/bussiness_config/bussiness_config.dart';
import 'package:snapcut/providers/app_theme_provider.dart';

void main() {
  AwesomeApp(
    app: App(),
    inAppReview: const InAppReviewConfig(enable: false),
    providers: [
      AwesomeAdvertisement.instance,
      AwesomeIAP.instance,
      AwesomeRemoteConfig.instance,
      AppThemeProvider(themeMode: ThemeMode.light, locale: const Locale('en')),
    ],
    lazyProviders: [
    ],
    onWillInitialize: () async {
      await initialize();

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
