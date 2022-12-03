import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';

abstract class IServices {
  IFirebaseService get firebase;

  SnapEdit get snapEdit;
}

class Services extends IServices {
  static final IServices _instance = Services._internal();
  static IServices get instance => _instance;

  factory Services() => _instance as Services;

  Services._internal();

  /// using BaseFirebaseServices when disable the Firebase
  // final firebase = BaseFirebaseServices();
  @override
  final IFirebaseService firebase = FirebaseService();

  @override
  final SnapEdit snapEdit = SnapEdit();
}
