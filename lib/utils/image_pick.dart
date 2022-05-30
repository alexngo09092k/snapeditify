import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapedit/common/logs.dart';

abstract class ImagePick {
  static final List<String> imageFormats = [
    '.jpeg',
    '.png',
    '.jpg',
    '.gif',
    '.webp',
    '.tif',
    '.heic'
  ];
  static const String channelName = 'snap edit image';
  static const String methodSaveImage = 'saveImage';
  static const int imageQuality = 25;
  static const double maxWidth = 10000;
  static const double maxHeight = 10000;

  static const String pleaseProvidePath = 'Please provide valid file path.';
  static const String fileIsNotImage = 'File on path is not an image.';
  static const MethodChannel _channel = MethodChannel(channelName);

  static Future<void> getFromGallery(Function(XFile) onImagePicked) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );
      if (pickedFile != null) {
        onImagePicked(pickedFile);
      }
    } catch (error) {
      printLog(error);
    }
  }

  static Future<void> getFromCamera(Function(XFile) onImagePicked) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );
      if (pickedFile != null) {
        onImagePicked(pickedFile);
      }
    } catch (error) {
      printLog(error);
    }
  }

  static Future<bool?> saveImage(String imageBase64, {String? albumName}) async {
    try {
      final Uint8List imageBytes = base64.decode(imageBase64);
      final directory = await getApplicationDocumentsDirectory();
      final File imageFile = File('${directory.path}/testImage.png');
      imageFile.writeAsBytesSync(List.from(imageBytes));
      return true;
    } catch (error) {
      return false;
    }
  }
}
