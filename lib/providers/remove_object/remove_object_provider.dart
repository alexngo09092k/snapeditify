// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/remove_object/widgets/ai_guide.dart';
import 'package:snapeditify/pages/remove_object/widgets/brush_guide.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_state.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/detected_object_vm.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IRemoveObjectProvider extends EditImageProvider with StorageProvider {
  @override
  RemoveObjectState get state;

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

  Future<bool> toAIOneTouchSuggest(BuildContext context);

  bool changeStrokeWidth(BuildContext context, double strokeWidth);

  bool changeStrokeColor(BuildContext context, Color strokeColor);

  bool showAutoAIGuide();

  bool showBrushGuide();
}

class RemoveObjectProvider extends IRemoveObjectProvider with ProviderDelegate {
  static final IRemoveObjectProvider _instance = RemoveObjectProvider.internal();

  static IRemoveObjectProvider get instance => _instance;

  RemoveObjectProvider.internal() {
    _state = RemoveObjectState();
    _state.addListener(notifyListeners);
  }

  late RemoveObjectState _state;
  @override
  RemoveObjectState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

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
  bool showAutoAIGuide() {
    int? num = AsyncStorage.instance.getInt(AsyncStorageKey.instance.autoAIGuide);
    if (num != null && num > 1) return false;

    WidgetUtils.instance.showDialog(builder: (_) => const AIGuide());
    AsyncStorage.instance.setInt(AsyncStorageKey.instance.autoAIGuide, num == null ? 1 : num + 1);
    return true;
  }

  @override
  bool showBrushGuide() {
    int? num = AsyncStorage.instance.getInt(AsyncStorageKey.instance.brushGuide);
    if (num != null && num > 1) return false;

    WidgetUtils.instance.showDialog(builder: (_) => const BrushGuide());
    AsyncStorage.instance.setInt(AsyncStorageKey.instance.brushGuide, num == null ? 1 : num + 1);
    return true;
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
    return _state.setImage(originalImage.imageBytes, originalImage.imageBase64);
  }

  @override
  Future<bool> toAIOneTouchSuggest(BuildContext context) async {
    if (_state.mode == RemoveObjectMode.ai) return true;

    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => toAIOneTouchSuggest(context));
    if (!result) return false;

    /// SHOW ADS
    adProvider.handleAd();
  
    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// CALL API
    OneTouchSuggestionBody body = OneTouchSuggestionBody(originalPreviewImage: _state.image.imageBytes);
    SnapEditResponse<OneTouchSuggestionResponse?> res = await Services.instance.snapEdit.removeOneTouch(body);

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
      _state.sessionId = res.data!.sessionId;

      /// AI MODE
      Debug.log("===== TO AI MODE ====");
      _state.mode = RemoveObjectMode.ai;

      /// HIDE LOADING POPUP
      LoadingPopup.hide();

      /// SHOW GUIDE
      showAutoAIGuide();

      return true;
    }

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).aiDetection, 
        message: S.of(context).failedToDetectObjectPleaseTryAgain, 
        retry: (_) => toAI(context),
      );
      Debug.log("===== TO AI DETECTED OBJECTS ${res.message} =====");
    }

    return false;
  }

  @override
  Future<bool> toAI(BuildContext context) async {
    if (_state.mode == RemoveObjectMode.ai) return true;

    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => toAI(context));
    if (!result) return false;

    /// SHOW ADS
    adProvider.handleAd();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// CALL API
    ScanObjectBody body = ScanObjectBody(originalPreviewImage: _state.image.imageBytes);
    SnapEditResponse<ScanObjectResponse?> res = await Services.instance.snapEdit.scanObject(body);

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
      _state.sessionId = res.data!.sessionId;

      /// AI MODE
      Debug.log("===== TO AI MODE ====");
      _state.mode = RemoveObjectMode.ai;

      /// HIDE LOADING POPUP
      LoadingPopup.hide();

      /// SHOW GUIDE
      showAutoAIGuide();

      return true;
    }

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).aiDetection, 
        message: S.of(context).failedToDetectObjectPleaseTryAgain, 
        retry: (_) => toAI(context),
      );
      Debug.log("===== TO AI DETECTED OBJECTS ${res.message} =====");
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
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => removeObjects(context));
    if (!result) return false;

    renewSavedFile();

    if (!canRemove) return false;

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    /// CALL API
    ui.Image mask = await _state.paint.renderMask(originalImage.size);
    Uint8List? maskBytes = await ImageUtils.instance.imageUIToBytes(mask);
    if (maskBytes == null) {
      /// HIDE LOADING POPUP
      LoadingPopup.hide();
      return false;
    }

    RemoveObjectBody body = RemoveObjectBody(originalPreviewImage: _state.image.imageBytes, maskBrush: maskBytes);
    SnapEditResponse<RemoveObjectResponse?> res = await Services.instance.snapEdit.removeObject(body);

    if (res.data != null) {
      /// CREATE NEW STATE WITH SET SESSION ID TO USED FOR NEXT STATE
      _state.next = _state.copyWith(prev: _state, drawables: []);

      /// MUST CALL SET IMAGE BEFORE SET FOR CURRENT STATE
      await _state.next!.setImage(base64.decode(res.data!.editedImage.image), res.data!.editedImage.image);

      /// AFTER NEXT STATE SETTED IMAGE
      _state.removeListener(notifyListeners);
      _state = _state.next!;
      _state.addListener(notifyListeners);
      notifyListeners();

      /// HIDE LOADING POPUP
      LoadingPopup.hide();
      return true;
    }

    /// HIDE LOADING POPUP
    LoadingPopup.hide();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).removeObjects, 
        message: S.of(context).failedToRemoveObjectsPleaseTryAgain, 
        retry: (_) => removeObjects(context),
      );
    }

    return false;
  }

  @override
  bool changeStrokeWidth(BuildContext context, double strokeWidth) {
    _state.strokeWidth = strokeWidth;

    /// CACHE LOCAL STORAGE
    AsyncStorage.instance.setDouble(AsyncStorageKey.instance.strokeWidth, _state.strokeWidth);
    return true;
  }

  @override
  bool changeStrokeColor(BuildContext context, Color strokeColor) {
    _state.strokeColor = strokeColor;

    /// CACHE LOCAL STORAGE
    AsyncStorage.instance.setInt(AsyncStorageKey.instance.strokeColor, _state.strokeColor.value);
    return true;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _compared = false;
    _strokeChanged = false;
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = RemoveObjectState(strokeColor: _state.strokeColor, strokeWidth: _state.strokeWidth);
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    _state.dispose();
    super.dispose();
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
    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    AsyncStorage.instance.remove(AsyncStorageKey.instance.strokeColor);
    AsyncStorage.instance.remove(AsyncStorageKey.instance.strokeWidth);
    return true;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {
    return;
  }

  @override
  void syncFromStorage([bool notify = false]) {
    int? strokeColor = AsyncStorage.instance.getInt(AsyncStorageKey.instance.strokeColor);
    if (strokeColor != null) {
      _state.strokeColor = Color(strokeColor);
    }

    double? strokeWidth = AsyncStorage.instance.getDouble(AsyncStorageKey.instance.strokeWidth);
    if (strokeWidth != null) {
      _state.strokeWidth = strokeWidth;
    }

    if (notify) notifyListeners();
  }
}
