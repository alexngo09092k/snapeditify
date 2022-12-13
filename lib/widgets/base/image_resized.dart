import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:snapedit/widgets/base/ui_image_display.dart';

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

extension ImageProviderUiImageGetter on ImageProvider {
  /// Returns an [ui.Image] object containing the image data from `this` object.
  Future<ui.Image> get image async {
    // Used to convert listener callback to future
    final completer = Completer<ui.Image>();

    // Resolve the image as an [ImageStream] and listen to the stream
    resolve(ImageConfiguration.empty).addListener(ImageStreamListener((info, _) {
      // Assign the [ui.Image] from the image information streamed as the completer value
      // When the image from the stream arrives, the completer is completed
      completer.complete(info.image);
    }));

    // Wait for the image data from the completer to arrive from the callback
    return await completer.future;
  }
}
