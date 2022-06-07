import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/controllers/edit/painter_state.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/models/ai_detection_body.dart';
import 'package:snapretouch/models/ai_detection_response.dart';
import 'package:snapretouch/models/detected_object.dart';
import 'package:snapretouch/models/erase_body.dart';
import 'package:snapretouch/models/erase_response.dart';
import 'package:snapretouch/repositories/ai_repository.dart';
import 'package:snapretouch/utils/image_convert.dart';
import 'package:snapretouch/utils/image_pick.dart';
import 'package:snapretouch/utils/internet_checking.dart';
import 'package:snapretouch/widgets/custom_snackbar.dart';
import 'package:snapretouch/widgets/loading_popup.dart';
import 'package:snapretouch/widgets/offline_popup.dart';
import 'package:snapretouch/modules/painter/painter.dart';

class EditValue {
  PainterState state;

  EditValue({
    required this.state,
  });
}

class EditController extends ValueNotifier<EditValue> {
  EditController({required this.context, required String imagePath}) : super(EditValue(state: PainterState())) {
    _initial(imagePath);
  }

  Future<void> _initial(String imagePath) async {
    _imagePath = imagePath;
    _internet = InternetChecking.getInstance();
    _internet.initialize('google.com');

    _aiRepository = AIRepository();

    state.addListener((event) {
      printLog('from edit controller $event');
      notifyListeners();
    });

    Uint8List normalBytes = File(imagePath).readAsBytesSync();
    printLog('Normal Image bytes => ${normalBytes.lengthInBytes}');

    Uint8List? compressBytes;
    if (normalBytes.lengthInBytes / 1024 > 500) { //500KB
      compressBytes = await FlutterImageCompress.compressWithFile(
        imagePath,
        quality: 50,
        format: CompressFormat.jpeg,
      );
    }
    if (compressBytes != null) {
      printLog('Compress Image byes => ${compressBytes.lengthInBytes}');
    }

    await state.setImage(
      image: await ImageConvert.imagePathToImage(imagePath),
      originalImageBase64: compressBytes != null
          ? ImageConvert.uint8ListToBase64(compressBytes)
          : ImageConvert.uint8ListToBase64(normalBytes),
    );
  }

  final BuildContext context;
  late String _imagePath;
  String get imagePath => _imagePath;

  late final InternetChecking _internet;

  late final AIRepository _aiRepository;

  PainterState get state => value.state;

  PainterController get painterController => state.controller;
  PainterState? get prevPainterState => state.prevState;
  double get strokeWidth => state.strokeWidth;
  Map<int, DetectedObject> get detectedObjects => state.detectedObjects;

  bool get isDraw => state.freeStyleMode == FreeStyleMode.draw;
  bool get isErase => state.freeStyleMode == FreeStyleMode.erase;
  bool get isAI => state.freeStyleMode == FreeStyleMode.none;

  //action
  bool get canUndo => state.canUndo;
  bool get canRedo => state.canRedo;
  bool get canCompare => state.canCompare;
  bool get canRemove {
    int setectedLength = state.detectedObjects.values
        .where((detectedObject) => detectedObject.isSelected)
        .length;
    int removedLength = state.detectedObjects.values
        .where((detectedObject) => detectedObject.isRemoved)
        .length;
    return painterController.drawables.isNotEmpty ||
        setectedLength > removedLength;
  }

  void undo() => state.undo();

  void redo() => state.redo();

  void toDraw() => state.toDraw();

  void toErase() => state.toErase();

  void toAI() async {
    if (!_internet.hasConnection) {
      printLog('No internet');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const OfflinePopup(),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (_) => LoadingPopup(
        message: S.of(context).workingOnYourPhotoNPleaseWaiting,
      ),
    );

    if (state.detectedObjects.values
        .where((detectedObject) => !detectedObject.isRemoved)
        .toList()
        .isNotEmpty) {
      state.toNone();
      Navigator.pop(context);
      return;
    }

    state.toNone();
    AIDetectionResponse? response = await _aiRepository.detectionImage(
      AIDetectionBody(originalImageBase64: state.originalImageBase64!),
    );

    if(response == null) {
      Navigator.pop(context);
      showSnackBar(context, type: SnackBarType.error, message: S.of(context).aiMessageFailure);
      return;
    }

    await state.setDetectedObjects(response.detectedObjects);
    await state.addAllBoxDetectedMask();
    
    Navigator.pop(context);
  }

  Future<void> remove({bool Function()? onStart, Function(EraseResponse?)? onEnd}) async {
    if (!_internet.hasConnection) {
      printLog('No internet');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const OfflinePopup(),
      );
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

    ui.Image mask = await state.generateMask();

    EraseResponse? response = await _aiRepository.eraseImage(
      EraseBody(
        originalImageBase64: state.originalImageBase64 ?? ImageConvert.imagePathToBase64(imagePath), // image will remove
        maskBase64: await ImageConvert.imageToBase64(mask),
      ),
    );

    if(response == null) {
      Navigator.pop(context);
      showSnackBar(context, type: SnackBarType.error, message: S.of(context).removeMessageFailure);
      return;
    }

    ui.Image newImage = await ImageConvert.base64ToImage(response.newImageBase64);

    Map<int, DetectedObject> updatedDetectedObject = state.detectedObjects.map((maskId, detetedObject) {
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

    value.state = state.withPrevNextState(
      image: newImage,
      originalImageBase64: response.newImageBase64,
      mode: state.freeStyleMode,
      drawables: [],
      canUndo: false,
    );

    await state.updateDetectedObject(updatedDetectedObject);

    state.addListener((event) {
      printLog('from edit controller $event');
      notifyListeners();
    });

    await state.addAllBoxDetectedMask();

    Navigator.pop(context);
  }

  void selectedDetectedObjects(int maskId) => state.addDetectedObjectMask(maskId);

  void unSelectedDtectedObjects(int maskId) => state.removeDetectedObjectMask(maskId);

  void compare() => state.compare();

  void revert() async {
    value.state = PainterState(
      image: await ImageConvert.imagePathToImage(imagePath),
      originalImageBase64: ImageConvert.imagePathToBase64(imagePath),
      strokeWidth: state.strokeWidth,
    );
    state.addListener((event) {
      printLog('from edit controller $event');
      notifyListeners();
    });
    notifyListeners();
  }

  Future<bool> saveImage(Function(String) onImagePath) async {
    final result = await ImageGallerySaver.saveImage(
      base64.decode(state.originalImageBase64!),
      quality: 60,
      name: 'test',
      isReturnImagePathOfIOS: true,
    );

    if (result != null && result['filePath'] != null) {
      String imagePath = result['filePath'];
      imagePath = imagePath.substring(7, imagePath.length);
      onImagePath(imagePath);
    }

    return result != null && result['isSuccess'] != null && result['isSuccess'];
  }

  Future<void> getFromGallery() async {
    Navigator.pop(context);
    ImagePick.getFromGallery((pickedFile) {
      _onImagePick(pickedFile);
    });
  }

  Future<void> getFromCamera() async {
    Navigator.pop(context);
    ImagePick.getFromCamera((pickedFile) {
      _onImagePick(pickedFile);
    });
  }

  _onImagePick(XFile pickedFile) async {
    printLog('on image picked');

    _imagePath = pickedFile.path;
    
     value.state = PainterState(
      image: await ImageConvert.imagePathToImage(imagePath),
      originalImageBase64: ImageConvert.imagePathToBase64(imagePath),
      strokeWidth: state.strokeWidth,
    );

    state.addListener((event) {
      printLog('from edit controller $event');
      notifyListeners();
    });
    notifyListeners();

    Navigator.pop(context);
    // Navigator.pushReplacementNamed(
    //   context,
    //   AppRoutes.edit,
    //   arguments: pickedFile,
    // );
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
