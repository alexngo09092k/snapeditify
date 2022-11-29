import 'dart:async';
import 'dart:io';
import 'package:fluttering/fluttering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapedit/utils/image_convert.dart';

class ImagePick {
  static final ImagePick _instance = ImagePick._internal();

  ImagePick get instance => _instance;

  ImagePick._internal();

  static final List<String> imageFormats = [
    '.jpeg',
    '.png',
    '.jpg',
    '.gif',
    '.webp',
    '.tif',
    '.heic'
  ];
  static const String channelName = 'snap retouch image';
  static const String methodSaveImage = 'saveImage';
  static const int imageQuality = 25;

  static const String pleaseProvidePath = 'Please provide valid file path.';
  static const String fileIsNotImage = 'File on path is not an image.';

  static Future<void> getFromGallery(Function(File) onImagePicked) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      );
      if (pickedFile != null) {
        File? imageFile = await ImageConvert.compressImage(File(pickedFile.path));
        if (imageFile != null) {
          onImagePicked(imageFile);
        }
      }
    } catch (error) {
      Debug.log(error);
    }
  }

  static Future<void> getFromCamera(Function(File) onImagePicked) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );
      if (pickedFile != null) {
        File? imageFile = await ImageConvert.compressImage(File(pickedFile.path));
        if (imageFile != null) {
          onImagePicked(imageFile);
        }
      }
    } catch (error) {
      Debug.log(error);
    }
  }
}
