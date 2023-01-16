// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/remove_object/remove_object_state.dart';
import 'package:phosart/providers/storage_provider.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/utils/image.dart';
import 'package:phosart/utils/widget.dart';
import 'package:phosart/view_models/detected_object_vm.dart';
import 'package:phosart/view_models/edited_image_vm.dart';
import 'package:phosart/widgets/painter/painter.dart';

abstract class IRemoveObjectProvider extends EditImageProvider with StorageProvider {
  bool get canRemove;
  bool get canUndo;
  bool get canRedo;
  bool get canCompare;
  bool get canRevert;
  bool get strokeWidthIsChanged;

  bool undo();

  bool redo();

  Future<bool> revert();

  Future<bool> compare();

  bool toBrush(BuildContext context);

  bool toErase(BuildContext context);

  Future<bool> removeObjects(BuildContext context);

  Future<bool> toAI(BuildContext context);

  bool changeStrokeWidth(BuildContext context, double strokeWidth);

  bool changeStrokeColor(BuildContext context, Color strokeColor);
}

class RemoveObjectProvider extends IRemoveObjectProvider with ProviderDelegate {
  static final IRemoveObjectProvider _instance = RemoveObjectProvider.internal();

  static IRemoveObjectProvider get instance => _instance;

  RemoveObjectProvider.internal() {
    _state = RemoveObjectState(
      strokeWidth: config.removeObject.strokeWidth.init.toDouble(),
      strokeColor: config.removeObject.strokeWidth.color,
    );
    _state.addListener(notifyListeners);
  }

  late RemoveObjectState _state;
  @override
  RemoveObjectState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBase64, _state.image.imageUI);

  @override
  bool get canUndo => _state.prev != null || _state.paint.canUndo;

  @override
  bool get canRedo => _state.next != null || _state.paint.canRedo;

  @override
  bool get canRemove {
    int setectedLength = _state.detectedObjects.values.where((detectedObject) => detectedObject.isSelected).length;
    int removedLength = _state.detectedObjects.values.where((detectedObject) => detectedObject.isRemoved).length;
    return _state.paint.drawables.isNotEmpty || setectedLength > removedLength;
  }

  @override
  bool get canCompare => _state.prev != null;

  bool _compared = false;
  @override
  Future<bool> compare() async {
    if (canCompare) {
      Debug.log("===== COMPARE ====");
      if (!_compared) {
        Debug.log("===== COMPARE ORIGINAL BACKGROUND====");
        _state.paint.background = originalImage.imageUI.backgroundDrawable;
        _compared = true;
      } else {
        Debug.log("===== COMPARE CURRENT BACKGROUND====");
        _state.paint.background = _state.image.imageUI.backgroundDrawable;
        _compared = false;
      }
      return true;
    }
    return false;
  }

  @override
  bool get canSave => _state.prev != null;

  @override
  bool get canRevert => _state.prev != null;

  bool _strokeChanged = false;

  @override
  bool get strokeWidthIsChanged => _strokeChanged;

  set strokeWidthIsChanged(bool value) {
    if (_strokeChanged != value) {
      _strokeChanged = value;
      notifyListeners();
    }
  }

  @override
  bool redo() {
    if (_state.paint.canRedo) {
      /// REDO PAINT
      Debug.log("===== PAINT REDO ====");
      _state.paint.redo();
      return true;
    } else if (_state.next != null) {
      /// REDO STATE
      Debug.log("===== STATE REDO ====");
      _state.removeListener(notifyListeners);
      _state = _state.next!..prev = _state;
      notifyListeners();
      return true;
    }
    return false;
  }

  @override
  bool undo() {
    if (_state.paint.canUndo) {
      /// UNDO PAINT
      Debug.log("===== PAINT UNDO ====");
      _state.paint.undo();
      return true;
    } else if (_state.prev != null) {
      /// UNDO STATE
      Debug.log("===== STATE UNDO ====");
      _state.removeListener(notifyListeners);
      _state = _state.prev!..next = _state;
      notifyListeners();
      return true;
    }
    return false;
  }

  @override
  Future<bool> revert() {
    Debug.log("===== REVERT ====");
    _state.removeListener(notifyListeners);
    _state = RemoveObjectState(
      strokeColor: _state.strokeColor,
      strokeWidth: _state.strokeWidth,
    );
    _state.addListener(notifyListeners);
    return _state.setImage(originalImage.imageBase64);
  }

  @override
  Future<bool> toAI(BuildContext context) async {
    if (_state.mode == RemoveObjectMode.ai) return true;

    /// SHOW ADS
    adProvider.handleAd();

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup(context);

    /// CALL API
    AIDetectionBody body = AIDetectionBody(originalPreviewImage: _state.image.imageBytes, sessionId: _state.sessionId);
    SnapEditResponse<AIDetectionResponse?> res = await Services.instance.snapEdit.detection(body);

    if (res.data != null) {
      /// DETECTED OBJECT VM
      Map<int, DetectedObjectVM> detectedObjectVMs = {};
      for (var detectedObject in res.data!.detectedObjects) {
        final vm = DetectedObjectVM.fromDetectedObject(detectedObject, _state);
        await vm.paintParse();
        detectedObjectVMs[vm.maskId] = vm;
      }
      _state.detectedObjects = detectedObjectVMs;

      /// SET NEW SESSION ID
      // _state.sessionId = res.data!.sessionId;

      /// AI MODE
      Debug.log("===== TO AI MODE ====");
      _state.mode = RemoveObjectMode.ai;

      /// HIDE LOADING POPUP
      Navigator.pop(context);
      return true;
    }

    /// HIDE LOADING POPUP
    Navigator.pop(context);

    if (res.error != null) {
      WidgetUtils.instance.alert(context, title: 'AI Mode', message: res.error.toString());
      Debug.log("===== TO AI DETECTED OBJECTS ${res.error} =====");
    }

    return false;
  }

  @override
  bool toBrush(BuildContext context) {
    if (_state.mode == RemoveObjectMode.brush) return true;

    /// CLEAR AI DETECTED OBJECTS
    for (var detectedObject in _state.detectedObjects.values) {
      _state.paint.removeDrawable(detectedObject.boxDrawble!);
    }

    /// BACK TO BRUSH MODE
    _state.mode = RemoveObjectMode.brush;
    Debug.log("===== TO BRUSH MODE ====");
    return true;
  }

  @override
  bool toErase(BuildContext context) {
    if (_state.mode == RemoveObjectMode.erase) return true;

    /// CLEAR AI DETECTED OBJECTS
    for (var detectedObject in _state.detectedObjects.values) {
      _state.paint.removeDrawable(detectedObject.boxDrawble!);
    }

    /// BACK TO ERASE MODE
    _state.mode = RemoveObjectMode.erase;
    Debug.log("===== TO ERASE MODE ====");

    return true;
  }

  @override
  Future<bool> removeObjects(BuildContext context) async {
    if (!canRemove) return false;

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup(context);

    /// CALL API
    ui.Image mask = await _state.paint.renderMask(originalImage.size);
    String? maskBase64 = await ImageUtils.instance.imageUIToBase64(mask);
    if (maskBase64 == null) {
      /// HIDE LOADING POPUP
      Navigator.pop(context);
      return false;
    }

    EraseBody body = EraseBody(originalPreviewImage: _state.image.imageBytes, maskBrush: base64.decode(maskBase64), sessionId: _state.sessionId);
    SnapEditResponse<EraseResponse?> res = await Services.instance.snapEdit.erase(body);

    if (res.data != null) {
      Debug.log("===== REMOVE OBJECTS ${res.data} =====");

      /// CREATE NEW STATE WITH SET SESSION ID TO USED FOR NEXT STATE
      _state.next = _state.copyWith(prev: _state, drawables: []);

      /// MUST CALL SET IMAGE BEFORE SET FOR CURRENT STATE
      await _state.next!.setImage(res.data!.editedImage.image);

      /// AFTER NEXT STATE SETTED IMAGE
      _state.removeListener(notifyListeners);
      _state = _state.next!;
      _state.addListener(notifyListeners);
      notifyListeners();

      /// HIDE LOADING POPUP
      Navigator.pop(context);
      return true;
    }

    /// HIDE LOADING POPUP
    Navigator.pop(context);

    if (res.error != null) {
      WidgetUtils.instance.alert(context, title: 'Remove Objects', message: res.error.toString());
      Debug.log("===== REMOVE OBJECTS ${res.error} =====");
    }

    return false;
  }

  @override
  bool changeStrokeWidth(BuildContext context, double strokeWidth) {
    _state.strokeWidth = strokeWidth;

    /// CACHE LOCAL STORAGE
    AsyncStorage.instance.setDouble(AppSharedKey.instance.strokeWidth, _state.strokeWidth);
    return true;
  }

  @override
  bool changeStrokeColor(BuildContext context, Color strokeColor) {
    _state.strokeColor = strokeColor;

    /// CACHE LOCAL STORAGE
    AsyncStorage.instance.setInt(AppSharedKey.instance.strokeColor, _state.strokeColor.value);
    return true;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _compared = false;
    _strokeChanged = false;
    _state.removeListener(notifyListeners);
    _state = RemoveObjectState(strokeColor: _state.strokeColor, strokeWidth: _state.strokeWidth);
    _state.addListener(notifyListeners);
    return true;
  }

  @override
  Future<bool> registered() {
    syncFromStorage();
    return super.registered();
  }

  @override
  void clean([bool notify = false]) {
    _compared = false;
    _strokeChanged = false;
    _state = RemoveObjectState();
    _state.strokeColor = config.removeObject.strokeWidth.color;
    _state.strokeWidth = config.removeObject.strokeWidth.init.toDouble();
    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AppSharedKey.instance.strokeColor);
    AsyncStorage.instance.remove(AppSharedKey.instance.strokeWidth);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    int? strokeColor = AsyncStorage.instance.getInt(AppSharedKey.instance.strokeColor);
    if (strokeColor != null) {
      _state.strokeColor = Color(strokeColor);
    }

    double? strokeWidth = AsyncStorage.instance.getDouble(AppSharedKey.instance.strokeWidth);
    if (strokeWidth != null) {
      _state.strokeWidth = strokeWidth;
    }

    if (notify) notifyListeners();
  }
}
