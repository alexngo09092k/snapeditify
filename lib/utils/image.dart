import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imagepkg;
import 'package:snapeditify/widgets/app_use/painter/extensions/extensions.dart';

class ImageUtils {
  static final ImageUtils _instance = ImageUtils._internal();

  static ImageUtils get instance => _instance;

  ImageUtils._internal() {
    _imagePicker = ImagePicker();
  }

  late ImagePicker _imagePicker;

  /// Pick image from camera or gallery
  Future<File?> pickImage(ImageSource from,
      {int? quality, Function(File)? onImage}) async {
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
      Debug.log('PICK IMAGE ERROR $error');
    }
    return null;
  }

  Future<ui.Image> toImageUI(Uint8List imageBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<Uint8List?> imageUIToBytes(ui.Image image) async {
    Uint8List? imageBytes = await image.pngBytes;
    return imageBytes;
  }

  Future<Uint8List> cropImage(Uint8List imageBytes,
      {required ui.Size size, required ui.Offset position}) async {
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    imagepkg.Image destImage = imagepkg.copyCrop(
      src!,
      x: position.dx.toInt(),
      y: position.dy.toInt(),
      width: size.width.toInt(),
      height: size.height.toInt(),
    );

    return imagepkg.encodePng(destImage);
  }

  Uint8List toJPG(Uint8List imageBytes) {
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    return imagepkg.encodeJpg(src!);
  }

  Uint8List toPNG(Uint8List imageBytes) {
    imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    return imagepkg.encodePng(src!);
  }

  /// Resize so longest side <= [maxSide].
  /// Returns original bytes if already small enough.
  /// Used before enhance/upscale API
  /// (max output 3000px → max input = 3000/zoom).
  Uint8List resizeToMaxSide(
    Uint8List imageBytes, {
    int maxSide = 1500,
    int quality = 92,
  }) {
    final imagepkg.Image? src = imagepkg.decodeImage(imageBytes);
    if (src == null) return imageBytes;

    final int w = src.width;
    final int h = src.height;
    final int longest = w > h ? w : h;
    if (longest <= maxSide) return imageBytes;

    final double scale = maxSide / longest;
    final int nw = (w * scale).round().clamp(1, maxSide);
    final int nh = (h * scale).round().clamp(1, maxSide);

    final imagepkg.Image resized = imagepkg.copyResize(
      src,
      width: nw,
      height: nh,
      interpolation: imagepkg.Interpolation.linear,
    );
    return imagepkg.encodeJpg(resized, quality: quality);
  }

  /// Max input side for SnapEdit enhance API given [zoomFactor].
  /// API: max output side 3000px → max input = 3000 ~/ zoom.
  static int maxInputSideForZoom(int zoomFactor, {int maxOutputSide = 3000}) {
    if (zoomFactor < 1) zoomFactor = 1;
    return maxOutputSide ~/ zoomFactor;
  }
}
