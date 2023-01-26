import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/services/snap_edit/snap_edit.dart';

export './snap_edit/snap_edit.dart';

abstract class IServices {
  IFirebaseService get firebase;

  SnapEdit get snapEdit;

  InAppReviewService get inAppReview;
}

class Services extends IServices {
  static final IServices _instance = Services._internal();
  static IServices get instance => _instance;

  factory Services() => _instance as Services;

  Services._internal();

  @override
  final IFirebaseService firebase = FirebaseService();

  @override
  final InAppReviewService inAppReview = InAppReviewService();

  @override
  final SnapEdit snapEdit = SnapEdit();
}
