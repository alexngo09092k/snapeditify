import 'package:flutter/foundation.dart';
import 'package:gms_check/gms_check.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/firebase_options.dart';
import 'package:snapedit/services/services.dart';

Future<void> initApp() async {
  if (isMobile) {
    await GmsCheck().checkGmsAvailability(enableLog: kDebugMode);

    /// Init Firebase settings due to version 0.5.0+ requires to.
    /// Use await to prevent any usage until the initialization is completed.
    await Services().firebase.init(Cofiguration.firebaseConfig, options: DefaultFirebaseOptions.currentPlatform);
    
    await Cofiguration().loadRemoteConfig();

    Services().advertisement.init(Cofiguration.adConfig);
  }

}
