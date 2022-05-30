import 'package:snapedit/controllers/edit/painter_state.dart';

abstract class PainterAction<T> {
  final PainterEvent event;
  final T? data;

  const PainterAction({
    required this.event,
    this.data,
  });

  @override
  String toString() => 'PainterAction(event: $event, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PainterAction<T> &&
      other.event == event &&
      other.data == data;
  }

  @override
  int get hashCode => event.hashCode ^ data.hashCode;
}

enum PainterEvent { undo, redo, other }

class PainterUndoAction extends PainterAction<PainterState>{
  const PainterUndoAction() : super(event: PainterEvent.undo);
}

class PainterRedoAction extends PainterAction<PainterState> {
  const PainterRedoAction() : super(event: PainterEvent.redo);
}

class PainterOtherAction extends PainterAction<PainterState> {
  const PainterOtherAction() : super(event: PainterEvent.other);
}