import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/controllers/edit/painter_state.dart';
import 'package:snapedit/models/ai_detection_body.dart';
import 'package:snapedit/models/ai_detection_response.dart';
import 'package:snapedit/models/detected_object.dart';
import 'package:snapedit/models/erase_body.dart';
import 'package:snapedit/models/erase_response.dart';
import 'package:snapedit/repositories/ai_repository.dart';
import 'package:snapedit/utils/image_convert.dart';
import 'package:snapedit/utils/image_pick.dart';
import 'package:snapedit/utils/internet_checking.dart';
import 'package:snapedit/widgets/loading_popup.dart';
import 'package:snapedit/widgets/offline_popup.dart';
import 'package:snapedit/modules/painter/painter.dart';

class EditValue {
  PainterState state;

  EditValue({
    required this.state,
  });
}

class EditController extends ValueNotifier<EditValue> {
  EditController({required this.context, required this.imagePath}): super(EditValue(state: PainterState())) {
    _initial();
  }

  Future<void> _initial() async{
    _internet = InternetChecking.getInstance();
    _internet.initialize('google.com');

    _aiRepository = AIRepository();

    state.addListener((event) {
      printLog('from edit controller $event');
      notifyListeners();
    });

    await state.setImage(
      image: await AssetImage(imagePath).image,
      originalImageBase64: ImageConvert.imagePathToBase64(imagePath),
    );
  }

  final BuildContext context;
  final String imagePath;

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
  bool get canRemove => canUndo || state.detectedObjects.values.where((detectedObject) => detectedObject.isSelected).length > state.detectedObjects.values.where((detectedObject) => detectedObject.isRemoved).length;

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
      builder: (_) => const LoadingPopup(
        message: 'Working on your photo. \n Please waiting...',
      ),
    );

    if (state.detectedObjects.values.where((detectedObject) => !detectedObject.isRemoved).toList().isNotEmpty) {
      state.toNone();
      return;
    }

    state.toNone();
    AIDetectionResponse? response = await _aiRepository.detectionImage(
      AIDetectionBody(originalImageBase64: state.originalImageBase64!),
    );

    if (response != null) {
      await state.setDetectedObjects(response.detectedObjects);
      await state.addAllBoxDetectedMask();
    }
    Navigator.of(context).pop();
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
      builder: (_) => const LoadingPopup(
        message: 'Removing object',
      ),
    );

    ui.Image mask = await state.generateMask();

    EraseResponse? response = await _aiRepository.eraseImage(
      EraseBody(
        originalImageBase64: state.originalImageBase64 ?? '', // image will remove
        maskBase64: await ImageConvert.imageToBase64(mask), // mask image
      ),
    );

    if (response != null) {
      ui.Image newImage = await ImageConvert.base64ToImage(response.newImageBase64);

      Map<int, DetectedObject> updatedDetectedObject = state.detectedObjects.map((maskId, detetedObject) {
        if (detetedObject.isSelected) {
          // painterController.removeDrawable(detetedObject.maskDrawable!, saveAction: false);
          painterController.removeDrawable(detetedObject.boxDrawble!, saveAction: false);
          return MapEntry(maskId, detetedObject.copyWith(isRemoved: true));
        }
        return MapEntry(maskId, detetedObject);
      });

      state.withPrevNextState(
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
    }

    await state.addAllBoxDetectedMask();

    Navigator.of(context).pop();
  }

  void selectedDetectedObjects(int maskId) => state.addDetectedObjectMask(maskId);

  void unSelectedDtectedObjects(int maskId) => state.removeDetectedObjectMask(maskId);

  void compare() => state.compare();

  void revert() => state.revert();

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
    Navigator.of(context).pop();
    ImagePick.getFromGallery((pickedFile) {
      _onImagePick(pickedFile);
    });
  }

  Future<void> getFromCamera() async {
    Navigator.of(context).pop();
    ImagePick.getFromCamera((pickedFile) {
      _onImagePick(pickedFile);
    });
  }

  _onImagePick(XFile pickedFile) {
    printLog('on image picked');
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.edit,
      arguments: pickedFile,
    );
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
