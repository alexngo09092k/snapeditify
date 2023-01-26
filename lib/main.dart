import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:fluttering_iap/iap/iap.dart';
import 'package:snapeditify/app.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/env/env.dart';
import 'package:snapeditify/firebase_options.dart';
import 'package:snapeditify/models/config/bussiness_config.dart';
import 'package:snapeditify/providers/anime_ai/anime_ai_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/restyle/restyle_provider.dart';
import 'package:snapeditify/services/services.dart';

void main() {
  AwesomeApp(
    app: const App(),
    providers: [AwesomeAdvertisement.instance, AwesomeIAP.instance, ThemeProvider.instance],
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
        Configuration.instance.firebase,
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await Configuration.instance.loadRemoteConfig();

      Debug.debugMode = Configuration.instance.business.appMode == AppMode.debug;

      AwesomeAdvertisement.instance.initial(Configuration.instance.advertisement);
      AwesomeIAP.instance.initial(Configuration.instance.iap);

      Services.instance.snapEdit.init(Configuration.instance.snapEdit);

      return true;
    },
  ).run();
}
