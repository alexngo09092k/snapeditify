import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_analytics/analytics/index.dart';
import 'package:fluttering_iap/iap/iap.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';
import 'package:snapeditify/app.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/enviroment.dart';
import 'package:snapeditify/firebase_options.dart';
import 'package:snapeditify/models/config/bussiness_config/bussiness_config.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/app_theme_provider.dart';
import 'package:snapeditify/providers/change_background/change_background_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/providers/change_sky/change_sky_provider.dart';
import 'package:snapeditify/services/services.dart';

void main() {
  AwesomeApp(
    app: const App(),
    inAppReview: const InAppReviewConfig(enable: false),
    providers: [
      AwesomeAdvertisement.instance,
      AwesomeIAP.instance,
      AwesomeRemoteConfig.instance,
      AwesomeAnalytics.instance,
      AppThemeProvider(themeMode: ThemeMode.light, locale: const Locale('en')),
    ],
    lazyProviders: [
      () => GalleryProvider.instance,
      () => RemoveObjectProvider.instance,
      () => EnhanceProvider.instance,
      () => RestoreProvider.instance,
      () => ChangeBackgroundProvider.instance,
      () => ChangeSkyProvider.instance,
      () => RestyleProvider.instance,
      () => AnimeAIProvider.instance,
      () => FastEditorProvider.instance,
    ],
    onWillInitialize: () async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // await Configuration.instance.loadLocalConfig(enviroment);

      AwesomeRemoteConfig.instance.initial(Configuration.instance.remoteConfig);

      return true;
    },
    onDidInitialize: () async {
      // await Configuration.instance.loadRemoteConfig();
      
      Debug.debugMode = Configuration.instance.business.appMode == AppMode.debug;

      AwesomeAdvertisement.instance.initial(Configuration.instance.advertisement);
      AwesomeIAP.instance.initial(Configuration.instance.iap);

      Services.instance.snapEdit.initital(Configuration.instance.snapEdit);

      return true;
    },
  ).run();
}
