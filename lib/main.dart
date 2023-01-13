import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_iap/iap/iap.dart';
import 'package:phosart/app.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/env/env.dart';
import 'package:phosart/firebase_options.dart';
import 'package:phosart/models/config/bussiness_config.dart';
import 'package:phosart/providers/anime_ai/anime_ai_provider.dart';
import 'package:phosart/providers/enhance/enhance_provider.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';
import 'package:phosart/providers/restyle/restyle_provider.dart';
import 'package:phosart/services/services.dart';

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
      () => AnimeAIProvider.instance,
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

      Debug.debugMode = Configuration.instance.businessConfig.appMode == AppMode.debug;

      return true;
    },
  ).run();
}
