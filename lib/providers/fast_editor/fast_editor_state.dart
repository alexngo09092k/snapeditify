import 'dart:typed_data';

import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';

class FastEditorState extends EditImageState {
  @override
  Future<bool> setImage(Uint8List imageBytes, String imageBase64, {EditImageProvider? provider, String? styleId}) async {
    final bool result = await super.setImage(imageBytes, imageBase64);
    return result;
  }
}
