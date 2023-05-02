import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_iap/iap/iap.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';
import 'package:snapeditify/app.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/enviroment.dart';
import 'package:snapeditify/firebase_options.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/app_theme_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/providers/sky/sky_provider.dart';
import 'package:snapeditify/services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  AwesomeApp(
    app: const App(),
    inAppReview: const InAppReviewConfig(enable: false),
    providers: [
      AwesomeAdvertisement.instance,
      AwesomeIAP.instance,
      AwesomeRemoteConfig.instance,
      AppThemeProvider(themeMode: ThemeMode.light, locale: const Locale('en')),
    ],
    lazyProviders: [
      () => GalleryProvider.instance,
      () => RemoverProvider.instance,
      () => EnhanceProvider.instance,
      () => RestyleProvider.instance,
      () => AnimeAIProvider.instance,
      () => SkyProvider.instance,
      () => RestoreProvider.instance,
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
      // await Configuration.instance.loadRemoteConfig();

      // Debug.debugMode = Configuration.instance.business.appMode == AppMode.debug;

      AwesomeAdvertisement.instance.initial(Configuration.instance.advertisement);
      AwesomeIAP.instance.initial(Configuration.instance.iap);

      Services.instance.snapEdit.initital(Configuration.instance.snapEdit);

      return true;
    },
  ).run();
}
