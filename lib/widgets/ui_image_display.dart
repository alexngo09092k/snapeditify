import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

class UIImageDisplay extends StatelessWidget {
  final ui.Image uiImage;
  final Widget placeholder;

  const UIImageDisplay({
    required this.uiImage,
    required this.placeholder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: encodeImage(),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else {
          return placeholder;
        }
      },
    );
  }

  Future<Uint8List?> encodeImage() async {
    ByteData? byteData =
        await uiImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return Uint8List.view(byteData.buffer);
    }
    return null;
  }
}
