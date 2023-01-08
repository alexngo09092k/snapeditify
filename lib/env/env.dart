import 'package:snapedit/env/advertisement.dart';
import 'package:snapedit/env/business.dart';
import 'package:snapedit/env/firebase.dart';
import 'package:snapedit/env/in_app_purchase.dart';
import 'package:snapedit/env/snap_edit.dart';

//! NOTE: UNIT TIME: SECONDS
Map<String, dynamic> enviroment = {
  /// FIREBASE
  "firebaseConfig": firebaseConfig,

  /// BUSSINESS
  "businessConfig": businessConfig,

  // ADVERTISEMENT
  "advertisementConfig": advertisementConfig,

  //IN APP PURCHASE
  "iapConfig": iapConfig,

  /// SNAPEDIT
  'snapEditConfig': snapEditConfig,
};
