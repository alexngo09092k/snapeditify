import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:snapedit/widgets/base/ui_image_display.dart';
import 'package:snapedit/widgets/painter/extensions/extensions.dart';

class ImageResized extends StatelessWidget {
  const ImageResized({super.key, required this.image, this.width, this.height, this.placeholder});
  final Widget image;
  final double? width;
  final double? height;
  final Widget? placeholder;

  factory ImageResized.fromImage(Image image, {double? width, double? height, Widget? placeholder}) {
    return ImageResized(
      image: FutureBuilder(
        future: image.image.image,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: snapshot.data!.width / snapshot.data!.height,
              child: image,
            );
          }
          return placeholder ?? const SizedBox();
        },
      ),
    );
  }

  factory ImageResized.fromBase64(String image, {double? width, double? height, Widget? placeholder}) {
    return ImageResized(
      image: FutureBuilder(
        future: image.image,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: snapshot.data!.width / snapshot.data!.height,
              child: UIImageDisplay(uiImage: snapshot.data!, placeholder: placeholder),
            );
          }
          return placeholder ?? const SizedBox();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: image,
      ),
    );
  }
}

extension StringUiImageGetter on String {
  Future<ui.Image> get image async {
    Uint8List imageBytes = base64.decode(this);
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }
}