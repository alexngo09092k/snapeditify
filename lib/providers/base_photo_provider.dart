import 'package:fluttering/fluttering.dart';

abstract class BasePhotoProvider extends Provider {
  Future<void> setPhoto(String photo);

  String get photo;
}