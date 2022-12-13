import 'dart:io';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/providers/enhance/enhance_state.dart';
import 'package:snapedit/services/services.dart';

abstract class IEnhanceProvider extends EditImageProvider {
  Future<bool> enhanceImage();

  // final Map<String, EnhanceState> _states = {};

  bool get isLoading;
}

class EnhanceProvider extends IEnhanceProvider {
  static final IEnhanceProvider _instance = EnhanceProvider.internal();

  static IEnhanceProvider get instance => _instance;

  EnhanceProvider.internal() {
    _state = EnhanceState();
    _state.addListener(notifyListeners);
  }

  final bool _isLoading = true;
  @override
  bool get isLoading => _isLoading;

  late EnhanceState _state;
  @override
  EnhanceState get state => _state;

  @override
  Future<bool> setImage(File file) async {
    await super.setImage(file);
    return enhanceImage();
  }

  @override
  Future<bool> enhanceImage() async {
    /// SHOW LOADING POPUP
    EnhanceBody body = EnhanceBody(inputImage: _state.imageFile, imageId: _state.imageId);
    final SnapEditResponse<EnhanceResponse?> res = await Services.instance.snapEdit.enhance(body);
    if (res.data != null) {
      /// HIDE LOADING POPUP
      _state = _state.copyWith();
      // await _state.setImage(res.data.faces);
      return true;
    }
    if (res.error != null) {
      Debug.log('===== ENAHNCE IMAGE ${res.error} =====');
    }

    /// HIDE LOADING POPUP
    return false;
  }
}
