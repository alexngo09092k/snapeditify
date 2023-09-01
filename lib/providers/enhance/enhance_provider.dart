// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_guide.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/enhance/enhance_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/view_models/enhanced_vm.dart';
import 'package:snapeditify/view_models/face_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

abstract class IEnhanceProvider extends EditImageProvider {
  @override
  EnhanceState get state;

  Future<bool> enhanceImage(BuildContext context);

  bool showEnhanceGuide();
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
      enhancedimage.imageBytes,
      enhancedimage.imageUI!,
    );
  }

  @override
  bool get canSave => _state.enhancedImages.isNotEmpty;

  @override
  Future<bool> enhanceImage(BuildContext context) async {
    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => enhanceImage(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show("Please wait amoment!");

    /// SHOW ADS
    adProvider.handleAd();

    /// CALL API
    EnhanceBody body = EnhanceBody(inputImage: _state.image.imageBytes, imageId: _state.imageId);
    final SnapEditResponse<EnhanceImageResponse?> res = await Services.instance.snapEdit.enhanceImage(body);
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
      WidgetUtils.instance.dimiss();

      /// SHOW GUIDE
      showEnhanceGuide();

      return true;
    }

    /// HIDE LOADING POPUP
    WidgetUtils.instance.dimiss();

    if (!res.status) {
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).enhanceImage, 
        message: S.of(context).failedToEnhanceImagePleaseTryAgain, 
        retry: (_) => enhanceImage(context),
      );
      Debug.log('===== ENAHNCE IMAGE ${res.message} =====');
    }

    return false;
  }

  @override
  bool showEnhanceGuide() {
    int? num = AsyncStorage.instance.getInt(AsyncStorageKey.instance.enhanceGuide);
    if (num != null && num > 1) return false;

    WidgetUtils.instance.showDialog(builder: (_) => const EnhanceGuide());
    AsyncStorage.instance.setInt(AsyncStorageKey.instance.autoAIGuide, num == null ? 1 : num + 1);
    return true;
  }

  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = EnhanceState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }
}
