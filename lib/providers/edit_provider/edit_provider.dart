// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:snapedit/providers/edit_provider/painter_state.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/services/snap_edit/models/ai_detection_body.dart';
import 'package:snapedit/services/snap_edit/models/ai_detection_response.dart';
import 'package:snapedit/models/detected_object.dart';
import 'package:snapedit/services/snap_edit/models/erase_body.dart';
import 'package:snapedit/services/snap_edit/models/erase_response.dart';
import 'package:snapedit/pages/remove_object/widgets/paint_control.dart';
import 'package:snapedit/services/snap_edit/models/snapedit_response.dart';
import 'package:snapedit/utils/image_convert.dart';
import 'package:snapedit/utils/image_pick.dart';
import 'package:snapedit/widgets/loading_popup.dart';
import 'package:snapedit/widgets/painter/painter.dart';
import 'package:snapedit/widgets/widget.utils.dart';

abstract class IEditProvider extends Provider {
  Future<void> setImage(String imagePath);
  String get imagePath;
  GlobalKey<PaintControlState> get painterControlKey;
  PainterState get state;
  PainterController get painterController;
  PainterState? get prevPainterState;
  double get strokeWidth;
  Map<int, DetectedObject> get detectedObjects;

  bool get isDraw;
  bool get isErase;
  bool get isAI;

  bool get canBack;

  //action
  bool get canUndo;
  bool get canRedo;
  bool get canCompare;
  bool get canRemove;

  void undo();

  void redo();

  void toDraw();

  void toErase();

  void toAI(BuildContext context);

  void revert();

  void compare();

  Future<void> remove(BuildContext context, {bool Function()? onStart, Function(EraseResponse?)? onEnd});

  Future<bool> saveImage(Function(String imagePath, String originalImageBase64) onImagePath);

  void selectedDetectedObjects(int maskId);

  void unSelectedDtectedObjects(int maskId);

  Future<void> getFromGallery(BuildContext context);

  Future<void> getFromCamera(BuildContext context);

  refresh();
}

class EditProvider extends IEditProvider {
  EditProvider() {
    _painterControlKey = GlobalKey<PaintControlState>();
    _state.addListener((event) {
      Debug.log('from edit controller $event');
      notifyListeners();
    });
  }

  @override
  Future<void> setImage(String imagePath) async {
    _imagePath = imagePath;

    Uint8List normalBytes = File(imagePath).readAsBytesSync();
    Debug.log('Normal Image bytes => ${normalBytes.lengthInBytes}');

    Uint8List? compressBytes;
    if (normalBytes.lengthInBytes / 1024 > 500) {
      //500KB
      compressBytes = await FlutterImageCompress.compressWithFile(
        imagePath,
        quality: 50,
        format: CompressFormat.jpeg,
      );
    }
    if (compressBytes != null) {
      Debug.log('Compress Image byes => ${compressBytes.lengthInBytes}');
    }

    await _state.setImage(
      image: await ImageConvert.imagePathToImage(imagePath),
      originalImageBase64: compressBytes != null ? ImageConvert.uint8ListToBase64(compressBytes) : ImageConvert.uint8ListToBase64(normalBytes),
    );
  }

  late String _imagePath;
  @override
  String get imagePath => _imagePath;

  late final GlobalKey<PaintControlState> _painterControlKey;

  @override
  GlobalKey<PaintControlState> get painterControlKey => _painterControlKey;

  PainterState _state = PainterState();
  @override
  PainterState get state => _state;

  @override
  PainterController get painterController => _state.controller;
  @override
  PainterState? get prevPainterState => _state.prevState;
  @override
  double get strokeWidth => _state.strokeWidth;
  @override
  Map<int, DetectedObject> get detectedObjects => _state.detectedObjects;

  @override
  bool get isDraw => _state.freeStyleMode == FreeStyleMode.draw;
  @override
  bool get isErase => _state.freeStyleMode == FreeStyleMode.erase;
  @override
  bool get isAI => _state.freeStyleMode == FreeStyleMode.none;

  bool _savedImage = false;
  @override
  bool get canBack => prevPainterState == null || _savedImage;

  //action
  @override
  bool get canUndo => _state.canUndo;
  @override
  bool get canRedo => _state.canRedo;
  @override
  bool get canCompare => _state.canCompare;
  @override
  bool get canRemove {
    int setectedLength = _state.detectedObjects.values.where((detectedObject) => detectedObject.isSelected).length;
    int removedLength = _state.detectedObjects.values.where((detectedObject) => detectedObject.isRemoved).length;
    return painterController.drawables.isNotEmpty || setectedLength > removedLength;
  }

  @override
  void undo() => _state.undo();

  @override
  void redo() => _state.redo();

  @override
  void toDraw() => _state.toDraw();

  @override
  void toErase() => _state.toErase();

  @override
  void toAI(BuildContext context) async {
    if (!InternetConnection.instance.hasConnection) {
      showNoInternetPopup(context);
      return;
    }

    showDialog<void>(
      context: context,
      builder: (_) => LoadingPopup(
        message: S.of(context).workingOnYourPhotoNPleaseWaiting,
      ),
    );

    if (_state.detectedObjects.values.where((detectedObject) => !detectedObject.isRemoved).toList().isNotEmpty) {
      _state.toNone();
      Navigator.pop(context);
      return;
    }

    _state.toNone();
    SnapEditResponse<AIDetectionResponse?> response = await Services.instance.snapEdit.detectionImage(
      AIDetectionBody(originalImageBase64: _state.originalImageBase64!),
    );

    if (response.data == null) {
      Navigator.pop(context);
      // showSnackBar(context, type: SnackBarType.error, message: S.of(context).aiMessageFailure);
      return;
    }

    await _state.setDetectedObjects(response.data!.detectedObjects);
    await _state.addAllBoxDetectedMask();

    Navigator.pop(context);
  }

  @override
  Future<void> remove(BuildContext context, {bool Function()? onStart, Function(EraseResponse?)? onEnd}) async {
    _savedImage = false;
    if (!InternetConnection.instance.hasConnection) {
      showNoInternetPopup(context);
      return;
    }

    // show loading
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingPopup(
        message: S.of(context).removingObject,
      ),
    );

    ui.Image mask = await _state.generateMask();

    SnapEditResponse<EraseResponse?> response = await Services.instance.snapEdit.eraseImage(
      EraseBody(
        originalImageBase64: _state.originalImageBase64 ?? ImageConvert.imagePathToBase64(imagePath), // image will remove
        maskBase64: await ImageConvert.imageToBase64(mask),
      ),
    );

    if (response.data == null) {
      Navigator.pop(context);
      // showSnackBar(context, type: SnackBarType.error, message: S.of(context).removeMessageFailure);
      return;
    }

    ui.Image newImage = await ImageConvert.base64ToImage(response.data!.newImageBase64);

    Map<int, DetectedObject> updatedDetectedObject = _state.detectedObjects.map((maskId, detetedObject) {
      if (detetedObject.isSelected) {
        // painterController.removeDrawable(detetedObject.maskDrawable!, saveAction: false);
        painterController.removeDrawable(
          detetedObject.boxDrawble!,
          saveAction: false,
        );
        return MapEntry(maskId, detetedObject.copyWith(isRemoved: true));
      }
      return MapEntry(maskId, detetedObject);
    });

    _state = _state.withPrevNextState(
      image: newImage,
      originalImageBase64: response.data!.newImageBase64,
      mode: _state.freeStyleMode,
      drawables: [],
      canUndo: false,
    );

    await _state.updateDetectedObject(updatedDetectedObject);

    _state.addListener((event) {
      Debug.log('from edit controller $event');
      notifyListeners();
    });

    await _state.addAllBoxDetectedMask();

    Navigator.pop(context);
  }

  @override
  void selectedDetectedObjects(int maskId) => _state.addDetectedObjectMask(maskId);

  @override
  void unSelectedDtectedObjects(int maskId) => _state.removeDetectedObjectMask(maskId);

  @override
  void compare() => _state.compare();

  @override
  void revert() async {
    _state = PainterState(
      image: await ImageConvert.imagePathToImage(imagePath),
      originalImageBase64: ImageConvert.imagePathToBase64(imagePath),
      strokeWidth: _state.strokeWidth,
    );
    _state.addListener((event) {
      Debug.log('from edit controller $event');
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  Future<bool> saveImage(Function(String imagePath, String originalImageBase64) onImagePath) async {
    final result = await ImageGallerySaver.saveImage(
      base64.decode(_state.originalImageBase64!),
      quality: 100,
      name: 'snappretouch_${DateTime.now().millisecondsSinceEpoch}',
      isReturnImagePathOfIOS: CurrentPlatform.instance.isIos,
    );

    Debug.log('saveImage $result');

    if (result != null && result['filePath'] != null) {
      _savedImage = true;
      String imagePath = result['filePath'];
      if (!((DeviceInfo.instance.android?.manufacturer ?? '').toUpperCase() == 'HUAWEI')) {
        imagePath = imagePath.substring(7, imagePath.length);
      } else {
        ///CACHE FILE
        File? imageFile = await ManagerCache.instance.cacheImage(_state.originalImageBase64!);
        if (imageFile != null) {
          Debug.log('image saved path fix for huawei ${imageFile.path}');
          imagePath = imageFile.path;
        }
      }
      onImagePath(imagePath, _state.originalImageBase64!);
    }

    return result != null && result['isSuccess'] != null && result['isSuccess'];
  }

  @override
  Future<void> getFromGallery(BuildContext context) async {
    Navigator.pop(context);
    // cleanCache();
    ImagePick.getFromGallery((pickedFile) {
      _onImagePick(context, pickedFile);
    });
  }

  @override
  Future<void> getFromCamera(BuildContext context) async {
    Navigator.pop(context);
    // cleanCache();
    ImagePick.getFromCamera((pickedFile) {
      _onImagePick(context, pickedFile);
    });
  }

  _onImagePick(BuildContext context, File pickedFile) async {
    if (_painterControlKey.currentState != null) {
      _painterControlKey.currentState!.hideDetail();
      toDraw();
    }

    Debug.log('on image picked');

    _imagePath = pickedFile.path;

    _state = PainterState(
      image: await ImageConvert.imagePathToImage(imagePath),
      originalImageBase64: ImageConvert.imagePathToBase64(imagePath),
      strokeWidth: _state.strokeWidth,
    );

    _state.addListener((event) {
      Debug.log('from edit controller $event');
      notifyListeners();
    });
    notifyListeners();

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  refresh() {
    _state = PainterState();
    _state.addListener((event) {
      Debug.log('from edit controller $event');
      notifyListeners();
    });
  }
}
