part of '../extensions.dart';

/// Adds a method to convert any [ui.Image] to a [Uint8List] using
/// the `ui.ImageByteFormat.png` (png) format.
extension UiImagePngUint8ListGetter on ui.Image {
  /// Returns the image byte data from the `this` as a [Uint8List] in png format.
  Future<Uint8List?> get pngBytes async {
    // Convert this image into byte data with the png format
    final byteData = await toByteData(format: ui.ImageByteFormat.png);

    // Return the Uint8List from the byte data buffer (if not null)
    return byteData?.buffer.asUint8List();
  }

  /// Returns the image byte data from the `this` as a [Uint8List] in png format.
  Future<Uint8List?> get rawRgbaBytes async {
    // Convert this image into byte data with the png format
    final byteData = await toByteData(format: ui.ImageByteFormat.rawRgba);

    // Return the Uint8List from the byte data buffer (if not null)
    return byteData?.buffer.asUint8List();
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
