import 'package:snapeditify/env/advertisement.dart';
import 'package:snapeditify/env/business.dart';
import 'package:snapeditify/env/firebase.dart';
import 'package:snapeditify/env/gallery.dart';
import 'package:snapeditify/env/in_app_purchase.dart';
import 'package:snapeditify/env/in_app_review.dart';
import 'package:snapeditify/env/snap_edit.dart';

//! NOTE: UNIT TIME: SECONDS
Map<String, dynamic> enviroment = {
  /// FIREBASE
  "firebase": firebase,

  /// IN APP REVIEW
  "inAppReview": inAppReview,

  /// BUSSINESS
  "business": business,

  /// GALLERY
  "gallery": gallery,

  // ADVERTISEMENT
  "advertisement": advertisement,

  //IN APP PURCHASE
  "iap": iap,

  /// SNAPEDIT
  'snapEdit': snapEdit,
};
