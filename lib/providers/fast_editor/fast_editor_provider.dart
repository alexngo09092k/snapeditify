// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/fast_editor/fast_editor_state.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';

abstract class IFastEditorProvider extends EditImageProvider {
  @override
  FastEditorState get state;

  @override
  Future<bool> save(BuildContext context, {Uint8List? imageBytes}) {
    return super.save(context);
  }
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

  EditedImageVM? _editedImage;
  @override
  EditedImageVM? get editedImage => _editedImage;

  @override
  Future<bool> save(BuildContext context, {Uint8List? imageBytes}) async {
    if(imageBytes != null) {
      ui.Image imageUI = await ImageUtils.instance.toImageUI(imageBytes);
      _editedImage = EditedImageVM(imageBytes, imageUI);
    }
    return super.save(context);
  }
}
