import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/widgets/painter/painter.dart';

enum RemoveObjectMode {
  ai,
  brush,
  erase,
}

class EditBackgroundState extends EditImageState {
  EditBackgroundState({
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
    _paint.addListener(notifyState);
  }

  EditBackgroundState copyWith({
    RemoveObjectMode? mode,
    Color? strokeColor,
    double? strokeWidth,
    List<Drawable>? drawables,
    String? sessionId,
    EditBackgroundState? prev,
    EditBackgroundState? next,
  }) {
    final other = EditBackgroundState(
      mode: mode ?? this.mode,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      drawables: drawables ?? paint.drawables,
    )
      .._sessionId = sessionId ?? this.sessionId
      .._prev = prev ?? this.prev
      .._next = next ?? this.next;

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
      notifyState();
    }
  }

  /// REMOVE OBJECT STROKE WIDTH
  late double _strokeWidth;
  double get strokeWidth => _strokeWidth;
  set strokeWidth(double value) {
    if (_strokeWidth != value) {
      _strokeWidth = value;
      _paint.freeStyleStrokeWidth = strokeWidth;
      notifyState();
    }
  }

  /// REMOVE OBJECT STROKE COLOR
  late Color _strokeColor;
  Color get strokeColor => _strokeColor;
  set strokeColor(Color value) {
    if (_strokeColor != value) {
      _strokeColor = value;
      _paint.freeStyleColor = strokeColor;
      notifyState();
    }
  }

  String? _sessionId;
  String? get sessionId => _sessionId;
  set sessionId(String? value) {
    _sessionId = value;
    notifyState();
  }

  /// PREV STATE
  EditBackgroundState? _prev;
  EditBackgroundState? get prev => _prev;
  set prev(EditBackgroundState? value) {
    if (_prev != value) {
      _prev = value;
      notifyState();
    }
  }

  /// NEXT STATE
  EditBackgroundState? _next;
  EditBackgroundState? get next => _next;
  set next(EditBackgroundState? value) {
    if (_next != value) {
      _next = value;
      notifyState();
    }
  }

  @override
  void dispose() {
    _paint.dispose();
    super.dispose();
  }
}

/// AI DETECTED OBECTS HANDLER
extension DetectedObjectEx on EditBackgroundState {
  _addAllBoxMask() {
    List<RectangleDrawable> drawables = [];
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
   
  }
}
