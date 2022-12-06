import 'package:snapedit/providers/base_photo_provider.dart';

abstract class IArtEffectProvider extends BasePhotoProvider {}

class ArtEffectProvider extends IArtEffectProvider {
  late String _photo;
  @override
  String get photo => _photo;

  @override
  Future<void> setPhoto(String photo) async {
    _photo = photo;
  }
}
