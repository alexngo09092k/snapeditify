// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/remover/widgets/ai_guide.dart';
import 'package:snapeditify/pages/remover/widgets/brush_guide.dart';
import 'package:snapeditify/providers/edit_background/edit_background_state.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/storage_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/detected_object_vm.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/painter/painter.dart';

abstract class IEditBackgroundProvider extends EditImageProvider with StorageProvider {
  @override
  EditBackgroundState get state;

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

  bool changeStrokeWidth(BuildContext context, double strokeWidth);

  bool changeStrokeColor(BuildContext context, Color strokeColor);

  bool showAutoAIGuide();

  bool showBrushGuide();
}

class EditBackgroundProvider extends IEditBackgroundProvider with ProviderDelegate {
  static final IEditBackgroundProvider _instance = EditBackgroundProvider.internal();

  static IEditBackgroundProvider get instance => _instance;

  EditBackgroundProvider.internal() {
    _state = EditBackgroundState();
    _state.addListener(notifyListeners);
  }

  late EditBackgroundState _state;
  @override
  EditBackgroundState get state => _state;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBase64, _state.image.imageUI);

  @override
  bool get canUndo => _state.prev != null || _state.paint.canUndo;

  @override
  bool get canRedo => _state.next != null || _state.paint.canRedo;

  @override
  bool get canRemove {
    return false;
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
    _state = EditBackgroundState(
      strokeColor: _state.strokeColor,
      strokeWidth: _state.strokeWidth,
    );
    _state.addListener(notifyListeners);
    return _state.setImage(originalImage.imageBase64);
  }

  @override
  Future<bool> toAI(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => toAI(context));
    if (!result) return false;

    if (_state.mode == RemoveObjectMode.ai) return true;

    /// SHOW ADS
    adProvider.handleAd();

    /// SHOW LOADING POPUP
    WidgetUtils.instance.showLoadingPopup();

    /// CALL API
   ScanObjectBody body = ScanObjectBody(originalPreviewImage: _state.image.imageBytes, sessionId: _state.sessionId);
    SnapEditResponse<ScanObjectResponse?> res = await Services.instance.snapEdit.scanObject(body);

    if (res.data != null) {
      /// SET NEW SESSION ID
      // _state.sessionId = res.data!.sessionId;

      /// AI MODE
      Debug.log("===== TO AI MODE ====");
      _state.mode = RemoveObjectMode.ai;

      /// HIDE LOADING POPUP
      WidgetUtils.instance.dimiss();

      /// SHOW GUIDE
      showAutoAIGuide();

      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

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

    /// BACK TO BRUSH MODE
    _state.mode = RemoveObjectMode.brush;
    Debug.log("===== TO BRUSH MODE ====");
    return true;
  }

  @override
  bool toErase(BuildContext context) {
    if (_state.mode == RemoveObjectMode.erase) return true;

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
    WidgetUtils.instance.showLoadingPopup();

    /// CALL API
    ui.Image mask = await _state.paint.renderMask(originalImage.size);
    String? maskBase64 = await ImageUtils.instance.imageUIToBase64(mask);
    if (maskBase64 == null) {
      /// HIDE LOADING POPUP
      WidgetUtils.instance.dimiss();
      return false;
    }

    RemoveObjectBody body = RemoveObjectBody(originalPreviewImage: _state.image.imageBytes, maskBrush: base64.decode(maskBase64), sessionId: _state.sessionId);
    SnapEditResponse<RemoveObjectResponse?> res = await Services.instance.snapEdit.removeObject(body);

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
      WidgetUtils.instance.dimiss();
      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).removeObjects, 
        message: S.of(context).failedToRemoveObjectsPleaseTryAgain, 
        retry: (_) => removeObjects(context),
      );
      Debug.log("===== REMOVE OBJECTS ${res.message} =====");
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
    _state = EditBackgroundState(strokeColor: _state.strokeColor, strokeWidth: _state.strokeWidth);
    _state.addListener(notifyListeners);
    return super.refresh(context);
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
    _state = EditBackgroundState();
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
