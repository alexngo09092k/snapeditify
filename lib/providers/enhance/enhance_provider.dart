import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/providers/enhance/enhance_state.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/view_models/edited_image_vm.dart';
import 'package:phosart/view_models/enhanced_vm.dart';
import 'package:phosart/view_models/face_vm.dart';
import 'package:phosart/widgets/painter/painter.dart';

abstract class IEnhanceProvider extends EditImageProvider {
  Future<bool> enhanceImage();
}

class EnhanceProvider extends IEnhanceProvider {
  static final IEnhanceProvider _instance = EnhanceProvider.internal();

  static IEnhanceProvider get instance => _instance;

  EnhanceProvider.internal() {
    _state = EnhanceState();
    _state.addListener(notifyListeners);
  }

  late EnhanceState _state;
  @override
  EnhanceState get state => _state;

  @override
  EditedImageVM get editedImage {
    final enhancedimage = _state.enhancedImages[_state.enhancedImageIndex];
    return EditedImageVM(
      enhancedimage.imageBase64,
      enhancedimage.imageUI!,
    );
  }

  @override
  bool get canSave => _state.enhancedImages.isNotEmpty;

  @override
  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    await super.setImage(context, bytes: bytes, refesh: refesh);
    return await enhanceImage();
  }

  @override
  Future<bool> enhanceImage() async {
    /// SHOW LOADING POPUP
    SmartDialog.showLoading();

    /// CALL API
    EnhanceBody body = EnhanceBody(inputImage: _state.image.imageBytes, imageId: _state.imageId);
    final SnapEditResponse<EnhanceResponse?> res = await Services.instance.snapEdit.enhance(body);
    if (res.data != null) {
      /// ENHANCED IMAGES
      List<EnhancedVM> enhancedImages = [];
      for (int index = 0; index < res.data!.outputImages.length; index++) {
        final vm = EnhancedVM(index: index, imageBase64: res.data!.outputImages[index], state: state);
        await vm.paintParse();
        enhancedImages.add(vm);
      }
      _state.enhancedImages = enhancedImages;
      _state.enhancedImageIndex = 0;
      _state.paintAfter.background = enhancedImages[state.enhancedImageIndex].imageUI!.backgroundDrawable;

      /// FACES
      List<FaceVM> faces = [];
      for (var e in res.data!.faces) {
        final vm = FaceVM.fromFace(e, state);
        await vm.paintParse();
        faces.add(vm);
      }
      _state.faces = faces;

      /// HIDE LOADING POPUP
      SmartDialog.dismiss();
      return true;
    }

    if (res.error != null) {
      SmartDialog.showToast(res.error!);
      Debug.log('===== ENAHNCE IMAGE ${res.error} =====');
    }

    /// HIDE LOADING POPUP
    SmartDialog.dismiss();
    return false;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = EnhanceState();
    _state.addListener(notifyListeners);
    return true;
  }
}
