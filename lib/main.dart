import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_iap/iap/iap.dart';
import 'package:snapedit/app.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/env.dart';
import 'package:snapedit/firebase_options.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';
import 'package:snapedit/models/config/app_config.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';
import 'package:snapedit/services/services.dart';

void main() {
  AwesomeApp(
    app: const App(),
    debugMode: kDebugMode,
    providers: [AwesomeAdvertisement.instance, AwesomeIAP.instance],
    lazyProviders: [
      () => GalleryProvider.instance,
      () => RemoveObjectProvider.instance,
      () => EnhanceProvider.instance,
      () => RestyleProvider.instance,
    ],
    onWillInitialize: () async {
      return Configuration.instance.fromEnviroment(enviroment);
    },
    onDidInitialize: () async {
      await Services.instance.firebase.init(
        Configuration.instance.firebaseConfig,
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await Configuration.instance.loadRemoteConfig();

      AwesomeAdvertisement.instance.initial(Configuration.instance.advertisementConfig);
      AwesomeIAP.instance.initial(Configuration.instance.iapConfig);

      Services.instance.snapEdit.init(Configuration.instance.snapEditConfig);

      Debug.debugMode = Configuration.instance.appConfig.appMode == AppMode.debug;

      return true;
    },
  ).run();
}
