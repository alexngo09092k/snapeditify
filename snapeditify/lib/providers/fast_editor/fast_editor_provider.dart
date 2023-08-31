import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_state.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';

abstract class IFastEditorProvider extends EditImageProvider {
  @override
  FastEditorState get state;
}

class FastEditorProvider extends IFastEditorProvider {
  static final IFastEditorProvider _instance = FastEditorProvider.internal();

  static IFastEditorProvider get instance => _instance;

  FastEditorProvider.internal() {
    _state = FastEditorState();
    _state.addListener(notifyListeners);
  }

  late FastEditorState _state;
  @override
  FastEditorState get state => _state;

  @override
  bool get canSave => true;

  @override
  EditedImageVM? get editedImage => throw UnimplementedError();
}
