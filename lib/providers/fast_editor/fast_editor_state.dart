import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';

class FastEditorState extends EditImageState {
  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, String? styleId}) async {
    final bool result = await super.setImage(imageBase64);
    return result;
  }
}
