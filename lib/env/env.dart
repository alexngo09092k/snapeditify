import 'package:phosart/env/advertisement.dart';
import 'package:phosart/env/business.dart';
import 'package:phosart/env/firebase.dart';
import 'package:phosart/env/in_app_purchase.dart';
import 'package:phosart/env/snap_edit.dart';

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
