import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';

enum PhotosFor {
  removeObject,
  enhanceImage,
  applyArtEffect,
}

abstract class IPhotoProvider extends Provider {
  PhotosFor photosFor = PhotosFor.removeObject;

  List<String> get suggestedImages;
}

class PhotoProvider extends IPhotoProvider {
  PhotosFor _photosFor = PhotosFor.removeObject;

  @override
  PhotosFor get photosFor => _photosFor;

  @override
  set photosFor(PhotosFor value) {
    if (_photosFor != value) {
      _photosFor = value;
      notifyListeners();
    }
  }

  Map<PhotosFor, List<String>> suggestedImagesStore = {
    PhotosFor.applyArtEffect: [
      AppAssets.instance.restyleDemo1,
      AppAssets.instance.restyleDemo2,
      AppAssets.instance.restyleDemo3,
    ],
    PhotosFor.enhanceImage: [
      AppAssets.instance.snapEditEnhanceDemo1,
      AppAssets.instance.snapEditEnhanceDemo2,
      AppAssets.instance.snapEditEnhanceDemo3,
    ],
    PhotosFor.removeObject: [
      AppAssets.instance.snapEditDemo1,
      AppAssets.instance.snapEditDemo2,
      AppAssets.instance.snapEditDemo3,
    ],
  };

  @override
  List<String> get suggestedImages => suggestedImagesStore[_photosFor] ?? [];
}
