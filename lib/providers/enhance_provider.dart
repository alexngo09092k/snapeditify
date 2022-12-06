import 'package:snapedit/providers/base_photo_provider.dart';

abstract class IEnhanceProvider extends BasePhotoProvider {

  enhancePhoto() {

  }

}

class EnhanceProvider extends IEnhanceProvider {
  late String _photo;
  @override
  String get photo => _photo;

  @override
  Future<void> setPhoto(String photo) async {
    _photo = photo;
  }

  
}
