import 'package:snapedit/modules/firebase/models/firebase_config.dart';

abstract class BaseFirebaseServices {
  /// check if the Firebase is enable or not
  bool get isEnabled => false;

  Future<void> init(FirebaseConfig config);

  dynamic getCloudMessaging();

  Future<String?> getMessagingToken();
}
