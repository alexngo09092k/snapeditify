import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart' as impk;
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class CameraImage extends StatelessWidget {
  const CameraImage({super.key, required this.onImage});
  final dynamic Function(Uint8List bytes, ImageSource type) onImage;

  _onPickCamera() async {
    File? file = await ImageUtils.instance.pickImage(impk.ImageSource.camera);
    if (file != null) {
      onImage(file.readAsBytesSync(), ImageSource.camera);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPickCamera,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
        child: const CustomIcon(CupertinoIcons.camera),
      ),
    );
  }
}
