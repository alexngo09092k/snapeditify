// ignore_for_file: file_names
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';

abstract class IServices {
  IFirebaseService get firebase;

  SnapEdit get snapEdit;
}
