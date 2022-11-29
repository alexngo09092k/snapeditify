import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapretouch/app.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/env.dart';
import 'package:snapretouch/firebase_options.dart';
import 'package:snapretouch/providers/edit_provider/edit_provider.dart';
import 'package:snapretouch/providers/home_provider.dart';
import 'package:snapretouch/services/services.dart';
import 'package:snapretouch/models/config/app_config.dart';

void main() {
  AwesomeApp(
    app: const App(),
    debugMode: kDebugMode,
    providers: [AwesomeAdvertisement()],
    lazyProviders: [
      () => HomeProvider(),
      () => EditProvider(),
    ],
    onWillInitialize: () async {
      return Configuration.instance.fromEnviroment(enviroment);
    },
    onDidInitialize: () async {
      await Configuration.instance.loadRemoteConfig();

      Services.instance.firebase.init(
        Configuration.instance.firebaseConfig,
        options: DefaultFirebaseOptions.currentPlatform,
      );

      Debug.log(Configuration.instance.snapEditConfig);

      Services.instance.snapEdit.init(Configuration.instance.snapEditConfig);

      Debug.debugMode = Configuration.instance.appConfig.appMode == AppMode.debug;

      return true;
    },
  ).run();
}
