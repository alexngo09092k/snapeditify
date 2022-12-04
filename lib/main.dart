import 'package:flutter/foundation.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapedit/app.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/env.dart';
import 'package:snapedit/firebase_options.dart';
import 'package:snapedit/providers/edit_provider/edit_provider.dart';
import 'package:snapedit/providers/gallery_provider.dart';
import 'package:snapedit/providers/home_provider.dart';
import 'package:snapedit/providers/photo_provider.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/models/config/app_config.dart';

void main() {
  AwesomeApp(
    app: const App(),
    debugMode: kDebugMode,
    providers: [AwesomeAdvertisement()],
    lazyProviders: [
      () => HomeProvider(),
      () => EditProvider(),
      () => GalleryProvider(),
      () => PhotoProvider(),
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
