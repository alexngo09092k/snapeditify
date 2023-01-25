import 'package:snapeditify/env/advertisement.dart';
import 'package:snapeditify/env/business.dart';
import 'package:snapeditify/env/firebase.dart';
import 'package:snapeditify/env/gallery.dart';
import 'package:snapeditify/env/in_app_purchase.dart';
import 'package:snapeditify/env/snap_edit.dart';

//! NOTE: UNIT TIME: SECONDS
Map<String, dynamic> enviroment = {
  /// FIREBASE
  "firebaseConfig": firebaseConfig,

  /// BUSSINESS
  "businessConfig": businessConfig,

  /// GALLERY
  "galleryConfig": galleryConfig,

  // ADVERTISEMENT
  "advertisementConfig": advertisementConfig,

  //IN APP PURCHASE
  "iapConfig": iapConfig,

  /// SNAPEDIT
  'snapEditConfig': snapEditConfig,
};
