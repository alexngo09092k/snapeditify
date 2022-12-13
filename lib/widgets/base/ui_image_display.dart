import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class UIImageDisplay extends StatelessWidget {
  const UIImageDisplay({
    super.key,
    required this.uiImage,
    this.placeholder,
    this.width,
    this.height,
  });

  final ui.Image uiImage;
  final Widget? placeholder;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: uiImage.unit8List,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            width: width,
            height: height,
          );
        }
        return placeholder ?? const SizedBox();
      },
    );
  }
}

extension UIImageUint8List on ui.Image {
  Future<Uint8List?> get unit8List async {
    ByteData? byteData = await toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      return Uint8List.view(byteData.buffer);
    }
    return null;
  }
}
