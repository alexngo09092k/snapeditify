import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:snapedit/common/logs.dart';
import 'package:snapedit/controllers/edit/painter_actions.dart';
import 'package:snapedit/models/detected_object.dart';
import 'package:snapedit/utils/image_convert.dart';
import 'package:snapedit/modules/painter/painter.dart';

class PainterState {
  PainterState({
    ui.Image? image,
    String? originalImageBase64,
    double? strokeWidth,
    List<Drawable>? drawables,
    FreeStyleMode mode = FreeStyleMode.draw,
  }) {

    final color = Colors.red.withOpacity(0.4);

    _currentState = this;

    _currentState._painterStream = StreamController<PainterAction>();

    /// create paint shape
    _currentState._shapePaint = Paint()
      ..strokeWidth = strokeWidth ?? 40
      ..color = Colors.red.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    /// defined painter
    _currentState._controller = PainterController(
      drawables: drawables,
      settings: PainterSettings(
        freeStyle: FreeStyleSettings(
            color: color,
            strokeWidth: strokeWidth ?? 40,
            mode: mode),
        shape: ShapeSettings(
          paint: _shapePaint,
        ),
        scale: const ScaleSettings(
          enabled: true,
          minScale: 1,
          maxScale: 5,
        ),
      ),
    );

    _currentState._controller.addListener(update);

    if (image != null) {
      setImage(image: image, originalImageBase64: originalImageBase64 ?? '');
    }

    update();
  }

  PainterState? _prevState;
  PainterState? get prevState => _prevState;

  late PainterState _currentState;

  PainterState? _nextState;
  PainterState? get nextState => _currentState._nextState;

  ui.Image? _image;
  ui.Image? get image => _image;

  ui.Image? _prevImage;
  ui.Image? get prevImage => _prevImage;

  ui.Image? _originalImage;
  ui.Image? get originalImage => _currentState._originalImage;

  String? _originalImageBase64;
  String? get originalImageBase64 => _currentState._originalImageBase64;

  late final StreamController<PainterAction> _painterStream;

  /// DETECTED OBJECTS
  Map<int, DetectedObject> _detectedObjects = {};
  Map<int, DetectedObject> get detectedObjects => _currentState._detectedObjects;
  List<DetectedObject> getDetectedObjectsByType(DetectedObjectType type) =>
      detectedObjects.values
          .where((element) => element.objectType == type)
          .toList();

  late PainterController _controller;
  PainterController get controller => _currentState._controller;

  late Paint _shapePaint;
  Paint get shapePaint => _currentState._shapePaint;
  set shapePaint(Paint newValue) {
    _currentState._shapePaint = newValue;
    _currentState._controller.shapePaint = newValue;
  }

  double get strokeWidth => _currentState._controller.freeStyleStrokeWidth;
  Color get strokeColor => _currentState._controller.freeStyleColor;
  set strokeWidth(double newValue) {
    _currentState._controller.freeStyleStrokeWidth = newValue;
  }

  FreeStyleMode get freeStyleMode => _currentState._controller.freeStyleMode;
  set freeStyleMode(FreeStyleMode newValue) {
    _currentState._controller.freeStyleMode = newValue;
  }

  bool get canUndo => _currentState._controller.canUndo || _currentState._prevState != null;
  bool get canRedo => _currentState._controller.canRedo || _currentState._nextState != null;

  Future<void> undo() async {
    if (_currentState._controller.canUndo) {
      printLog('undo action same draw');
      _currentState._controller.undo();
    } else if (_currentState.prevState != null) {
      printLog('undo painter state');
      _currentState = _currentState.prevState!;
      update(const PainterUndoAction());
    }
  }

  Future<void> redo() async {
    if (_currentState._controller.canRedo) {
      printLog('redo action same draw');
      _currentState._controller.redo();
    } else if (_currentState.nextState != null) {
      printLog('redo painter state');
      _currentState = _currentState.nextState!;
      update(const PainterRedoAction());
    }
  }

  void toNone() {
    if (_currentState.freeStyleMode != FreeStyleMode.none) {
      _currentState.freeStyleMode = FreeStyleMode.none;
    }
  }

  void toErase() async {
    await removeAllBoxDetectedMask();
    if (_currentState.freeStyleMode != FreeStyleMode.erase) {
      _currentState.freeStyleMode = FreeStyleMode.erase;
    }
  }

  void toDraw() async {
    await removeAllBoxDetectedMask();
    if (_currentState.freeStyleMode != FreeStyleMode.draw) {
      _currentState.freeStyleMode = FreeStyleMode.draw;
    }
  }

  Future<void> compare () async {
    if(_currentState._prevImage != null) {
      printLog('compare');
      await setImage(image: _currentState._prevImage!);
    }
  }

  Future<void> revert() async{
    _controller.clearDrawables(saveAction: false);
    if(_image != null) {
      await setImage(
      image: _currentState._image!,
      originalImageBase64: _currentState._originalImageBase64,
    );
    }
  }

  Future<ui.Image> generateMask() async {
    final backgroundImageSize = Size(
      _currentState._image!.width.toDouble(),
      _currentState._image!.height.toDouble(),
    );
    final ui.Image image = await _currentState._controller.renderMask(backgroundImageSize);
    return image;
  }

    Future<ui.Image> generateImageWithMask() async {
    final backgroundImageSize = Size(
      _currentState._image!.width.toDouble(),
      _currentState._image!.height.toDouble(),
    );
    final ui.Image image = await _currentState._controller.renderImage(backgroundImageSize);

    return image;
  }

  Future<void> setDetectedObjects(List<DetectedObject> detectedObjects,{bool parse = true}) async {
    _currentState._detectedObjects.clear();
    for (var detectedObject in detectedObjects) {
      if (parse) {
        final renderBox = _currentState._controller.painterKey.currentContext?.findRenderObject() as RenderBox?;
        await detectedObject.paintParse(
          realSize: ui.Size(_currentState._image!.width.toDouble(), _currentState._image!.height.toDouble()),
          viewSize: renderBox!.size,
          onTap: (position) => removeDetectedObjectMask(detectedObject.maskId),
          originalImageBase64: _currentState._originalImageBase64!,
        );
        _currentState._detectedObjects[detectedObject.maskId] = detectedObject;
      }
    }
  }

  Future<void> updateDetectedObject(Map<int, DetectedObject> detectedObjects) async {
    _currentState._detectedObjects = detectedObjects;
  }

  bool removeBoxDetectedMask(maskId) {
    if (_currentState._detectedObjects[maskId] == null) {
      return true;
    }
    return _currentState._controller.removeDrawable(_currentState.detectedObjects[maskId]!.boxDrawble!, saveAction: false);
  }

  Future<void> removeAllBoxDetectedMask() async {
    _currentState._detectedObjects.forEach((key, value) {
      _currentState._controller.removeDrawable(value.boxDrawble!, saveAction: false);
    });
  }

  Future<void> addAllBoxDetectedMask() async {
    List<RectangleDrawable> drawables = [];
    for (var detectedObject in _currentState.detectedObjects.values) {
      if (!detectedObject.isRemoved) {
        drawables.add(detectedObject.boxDrawble!.copyWith(
          onTap: (position) {
            addDetectedObjectMask(detectedObject.maskId);
          },
        ));
      }
    }

    if(drawables.isNotEmpty) {
      printLog('update shape paint for box mask');
       _currentState._controller.shapeFactory = RectangleFactory(borderRadius: BorderRadius.zero);
      printLog('addAllBoxDetectedMask');
      _currentState._controller.addDrawables(drawables, saveAction: false);
      printLog('back shape paint');
      _currentState._controller.shapeFactory = null;
    }
  }

  Future<bool> removeDetectedObjectMask(int maskId) async {
    if (_currentState._detectedObjects[maskId] == null) {
      return true;
    }

    _currentState._detectedObjects = _currentState._detectedObjects.map((id, detectedObject) {
      var newDetectedObject = detectedObject;
      if (id == maskId) {
        newDetectedObject.isSelected = false;
      }
      return MapEntry(id, newDetectedObject);
    });

    _currentState._controller.removeDrawable(_detectedObjects[maskId]!.maskDrawable!, saveAction: false);

    return _currentState._detectedObjects[maskId]!.isSelected;
  }

  Future<void> addDetectedObjectMask(int maskId) async {
    if (_currentState._detectedObjects[maskId] == null) {
      return;
    }
    _currentState._detectedObjects = _currentState._detectedObjects.map((id, detectedObject) {
      var newDetectedObject = detectedObject;
      if (id == maskId) {
        newDetectedObject.isSelected = true;
      }
      return MapEntry(id, newDetectedObject);
    });

    _currentState._controller.addDrawables([_currentState._detectedObjects[maskId]!.maskDrawable!], saveAction: false);
  }

  Future<void> addAllDetectedObjectMask() async {
    List<ImageDrawable> drawables = [];
    for (var detectedObject in _currentState.detectedObjects.values) {
      if (!detectedObject.isSelected) {
        drawables.add(detectedObject.maskDrawable!);
      }
    }

    if(drawables.isNotEmpty) {
      printLog('addAllDetectedObjectMask');
      _currentState._controller.addDrawables(drawables, saveAction: false);
    }
  }

  Future<void> setImage({required ui.Image image, String? originalImageBase64}) async {
    _prevImage = _image;
    _currentState._image = image;

    _currentState._controller.background = image.backgroundDrawable;

    if(originalImageBase64 != null)  {
      _currentState._originalImageBase64 = originalImageBase64;
      _currentState._originalImage = await ImageConvert.base64ToImage(originalImageBase64);
    }
  }

  PainterState copyWith({
    ui.Image? image,
    String? originalImageBase64,
    double? strokeWidth,
    List<Drawable>? drawables,
    Map<int, DetectedObject>? detectedObjects,
    FreeStyleMode? mode,
    bool canUndo = true,
  }) {
    return PainterState(
      image: image ?? this.image,
      originalImageBase64: originalImageBase64 ?? this.originalImageBase64,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    )
      .._controller.addDrawables(drawables ?? _controller.drawables, saveAction: canUndo)
      .._controller.freeStyleMode = mode ?? _controller.freeStyleMode
      .._detectedObjects = detectedObjects ?? this.detectedObjects;
  }

  PainterState withPrevNextState({
    ui.Image? image,
    String? originalImageBase64,
    double? strokeWidth,
    List<Drawable>? drawables,
    Map<int, DetectedObject>? detectedObjects,
    FreeStyleMode? mode,
    bool canUndo = true,
  }) {
    final newState = PainterState(
      image: image ?? _currentState.image,
      originalImageBase64: originalImageBase64 ?? _currentState.originalImageBase64,
      strokeWidth: strokeWidth ?? _currentState.strokeWidth,
    )
      .._prevImage = _currentState.originalImage
      .._controller.addDrawables(drawables ?? _currentState._controller.drawables, saveAction: canUndo)
      .._controller.freeStyleMode = mode ?? _currentState._controller.freeStyleMode
      .._detectedObjects = detectedObjects ?? _currentState.detectedObjects;

    _currentState._nextState = newState;
    newState._prevState = _currentState;

    _currentState = newState;

    return _currentState;
  }

  void update([PainterAction action = const PainterOtherAction()]) {
    _currentState._painterStream.sink.add(action);
  }

  void addListener(Function(PainterAction) listener){
    _currentState._painterStream.stream.listen(listener);
  }

  dispose () {
    if(_currentState._nextState != null) _currentState._nextState!.dispose();
    if(_currentState._prevState  != null) _currentState._prevState!.dispose();
    _currentState._controller.dispose();
    _currentState._painterStream.close();
  }
}