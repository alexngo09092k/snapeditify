import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phosart/view_models/detected_object_vm.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/edit_image_state.dart';
import 'package:phosart/widgets/painter/painter.dart';

enum RemoveObjectMode {
  ai,
  brush,
  erase,
}

class RemoveObjectState extends EditImageState {
  RemoveObjectState({
    RemoveObjectMode mode = RemoveObjectMode.brush,
    Color strokeColor = Colors.red,
    double strokeWidth = 40,
    List<Drawable>? drawables,
  }) {
    _mode = mode;
    _strokeColor = strokeColor;
    _strokeWidth = strokeWidth;
    _paint = PainterController(
      drawables: drawables,
      settings: PainterSettings(
        freeStyle: FreeStyleSettings(
          color: _strokeColor,
          strokeWidth: _strokeWidth,
          mode: mode == RemoveObjectMode.brush ? FreeStyleMode.draw : FreeStyleMode.none,
        ),
        shape: ShapeSettings(
          paint: Paint()
            ..strokeWidth = _strokeWidth
            ..color = _strokeColor
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round,
        ),
        scale: const ScaleSettings(
          enabled: true,
          minScale: 1,
          maxScale: 5,
        ),
      ),
    );
    _paint.addListener(notifyListeners);
  }

  RemoveObjectState copyWith({
    RemoveObjectMode? mode,
    Color? strokeColor,
    double? strokeWidth,
    List<Drawable>? drawables,
    String? sessionId,
    Map<int, DetectedObjectVM>? detectedObjects,
    RemoveObjectState? prev,
    RemoveObjectState? next,
  }) {
    final other = RemoveObjectState(
      mode: mode ?? this.mode,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      drawables: drawables ?? paint.drawables,
    )
      .._sessionId = sessionId ?? this.sessionId
      .._prev = prev ?? this.prev
      .._next = next ?? this.next;

    other._detectedObjects.addAll((detectedObjects ?? this.detectedObjects).map((maskId, detectedObject) {
      return MapEntry(maskId, detectedObject.copyWith(state: other, isRemoved: detectedObject.isSelected));
    }));

    if (other.mode == RemoveObjectMode.ai) {
      other._addAllBoxMask();
    } else {
      other._removeAllBoxMask();
    }

    return other;
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider}) async {
    await super.setImage(imageBase64);
    _paint.background = image.imageUI.backgroundDrawable;
    return true;
  }

  /// AI DETECTED OBJECT
  final Map<int, DetectedObjectVM> _detectedObjects = {};
  Map<int, DetectedObjectVM> get detectedObjects => _detectedObjects;
  set detectedObjects(Map<int, DetectedObjectVM> value) {
    _detectedObjects.clear();
    _detectedObjects.addAll(value);
    _addAllBoxMask();
    notifyListeners();
  }

  /// PAINT
  late PainterController _paint;
  PainterController get paint => _paint;

  /// REMOVE OBJECT MODE
  late RemoveObjectMode _mode;
  RemoveObjectMode get mode => _mode;
  set mode(RemoveObjectMode value) {
    if (_mode != value) {
      _mode = value;
      switch (_mode) {
        case RemoveObjectMode.ai:
          _paint.freeStyleMode = FreeStyleMode.none;
          break;
        case RemoveObjectMode.brush:
          _removeAllBoxMask();
          _paint.freeStyleMode = FreeStyleMode.draw;
          break;
        case RemoveObjectMode.erase:
          _removeAllBoxMask();
          _paint.freeStyleMode = FreeStyleMode.erase;
          break;
        default:
          break;
      }
      notifyListeners();
    }
  }

  /// REMOVE OBJECT STROKE WIDTH
  late double _strokeWidth;
  double get strokeWidth => _strokeWidth;
  set strokeWidth(double value) {
    if (_strokeWidth != value) {
      _strokeWidth = value;
      _paint.freeStyleStrokeWidth = strokeWidth;
      notifyListeners();
    }
  }

  /// REMOVE OBJECT STROKE COLOR
  late Color _strokeColor;
  Color get strokeColor => _strokeColor;
  set strokeColor(Color value) {
    if (_strokeColor != value) {
      _strokeColor = value;
      _paint.freeStyleColor = strokeColor;
      notifyListeners();
    }
  }

  String? _sessionId;
  String? get sessionId => _sessionId;
  set sessionId(String? value) {
    _sessionId = value;
    notifyListeners();
  }

  /// PREV STATE
  RemoveObjectState? _prev;
  RemoveObjectState? get prev => _prev;
  set prev(RemoveObjectState? value) {
    if (_prev != value) {
      _prev = value;
      notifyListeners();
    }
  }

  /// NEXT STATE
  RemoveObjectState? _next;
  RemoveObjectState? get next => _next;
  set next(RemoveObjectState? value) {
    if (_next != value) {
      _next = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _paint.dispose();
    super.dispose();
  }
}

/// AI DETECTED OBECTS HANDLER
extension DetectedObjectEx on RemoveObjectState {
  _addAllBoxMask() {
    List<RectangleDrawable> drawables = [];
    for (var detectedObject in _detectedObjects.values) {
      /// IF DETECTED OBJECT IS NOT REMOVED, PAINT SELECTED BOX
      if (!detectedObject.isRemoved) {
        drawables.add(detectedObject.boxDrawble!);
      }
    }
    if (drawables.isNotEmpty) {
      /// UPDATE SHAPE PAINT FOR SELECTED BOX
      _paint.shapeFactory = RectangleFactory(borderRadius: BorderRadius.zero);

      /// ADD ALL SELECTED BOX
      _paint.addDrawables(drawables, saveAction: false);

      /// BACK SHAPE PAINT FOR SELECTED BOX
      _paint.shapeFactory = null;
    }
  }

  _removeAllBoxMask() {
    for (var detectedObject in _detectedObjects.values) {
      _paint.removeDrawable(detectedObject.boxDrawble!, saveAction: false);
    }
  }
}
