import 'dart:async';
import 'dart:io';
import 'package:fluttering/fluttering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imagepkg;

class ImageUtils {
  static final ImageUtils _instance = ImageUtils._internal();

  static ImageUtils get instance => _instance;

  ImageUtils._internal() {
    _imagePicker = ImagePicker();
  }

  late ImagePicker _imagePicker;

  /// Pick image from camera or gallery
  Future<File?> pickImage(ImageSource from, {int? quality, Function(File)? onImage}) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: from,
        imageQuality: quality,
      );
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        if (onImage != null) onImage(image);
        return image;
      }
    } catch (error) {
      Debug.log(error);
    }
    return null;
  }

  Future<ui.Image> base64ToImageUI(String imageBase64) async {
    Uint8List imageBytes = base64.decode(imageBase64);
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<ui.Image> imageFileToImageUI(File file) async {
    return Image.file(file).image.image;
  }

  Future<String?> imageUIToBase64(ui.Image image) async {
    Uint8List? imageBytes = await image.pngBytes;
    if (imageBytes != null) {
      return base64.encode(imageBytes);
    }
    return null;
  }

  String imageFileToBase64(File file) {
    return base64.encode(file.readAsBytesSync());
  }

  String uint8ListToBase64(Uint8List bytes) {
    return base64.encode(bytes);
  }

  Future<Uint8List> cropImageFile(File file, {required ui.Size size, required ui.Offset position}) async {
    var bytes = await file.readAsBytes();
    imagepkg.Image? src = imagepkg.decodeImage(bytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      position.dx.toInt(),
      position.dy.toInt(),
      size.width.toInt(),
      size.height.toInt(),
    );
    return destImage.getBytes();
  }

  Future<String> cropImageBase64(String imageBase64, {required ui.Size size, required ui.Offset position}) async {
    Uint8List imageBytes = base64.decode(imageBase64);
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      position.dx.toInt(),
      position.dy.toInt(),
      size.width.toInt(),
      size.height.toInt(),
    );

    return base64.encode(imagepkg.encodePng(destImage));
  }

  Future<File?> compressImageFile(
    File file, {
    int minWidth = 1000,
    int minHeight = 1000,
    int quality = 95,
    CompressFormat format = CompressFormat.jpeg,
  }) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    File? compressedFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      minWidth: minWidth,
      minHeight: minHeight,
      quality: quality,
      format: format,
    );
    return compressedFile;
  }

  File pngToJpeg(File file) {
    final name = file.path.split('.').first;
    final image = imagepkg.decodeImage(file.readAsBytesSync())!;
    final jpegFile = File('$name.jpeg')..writeAsBytesSync(imagepkg.encodeJpg(image));
    return jpegFile;
  }
}

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

/// Adds a method to get a [ui.Image] object from any [ImageProvider].
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
