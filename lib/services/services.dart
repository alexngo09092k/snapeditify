import 'package:snapeditify/services/snap_edit/snap_edit.dart';

export './snap_edit/snap_edit.dart';

abstract class IServices {
  SnapEdit get snapEdit;
}

class Services extends IServices {
  static final IServices _instance = Services._internal();
  static IServices get instance => _instance;

  factory Services() => _instance as Services;

  Services._internal();

  @override
  final SnapEdit snapEdit = SnapEdit();
}
