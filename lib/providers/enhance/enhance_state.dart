import 'package:snapedit/providers/edit_image_provider.dart';
import 'package:snapedit/view_models/enhanced_vm.dart';
import 'package:snapedit/providers/edit_image_state.dart';
import 'package:snapedit/view_models/face_vm.dart';
import 'package:snapedit/widgets/painter/painter.dart';

class EnhanceState extends EditImageState {
  EnhanceState() {
    _paintBefore = PainterController();
    _paintBefore.addListener(notifyListeners);

    _paintAfter = PainterController();
    _paintAfter.addListener(notifyListeners);
  }

  @override
  Future<bool> setImage(String imageBase64, {EditImageProvider? provider, bool createImageFile = true}) async {
    final bool result = await super.setImage(imageBase64, provider: provider);
    if (result) {
      _paintBefore.background = imageUI.backgroundDrawable;
      _paintAfter.background = imageUI.backgroundDrawable;
    }
    return result;
  }

  /// PAINT
  late PainterController _paintBefore;
  PainterController get paintBefore => _paintBefore;

  late PainterController _paintAfter;
  PainterController get paintAfter => _paintAfter;

  String? _imageId;
  String? get imageId => _imageId;
  set imageId(String? value) {
    _imageId = value;
    notifyListeners();
  }

  int _enhancedImageIndex = 0;
  int get enhancedImageIndex => _enhancedImageIndex;
  set enhancedImageIndex(int value) {
    _enhancedImageIndex = value;
    notifyListeners();
  }

  final List<EnhancedVM> _enhancedImages = [];
  List<EnhancedVM> get enhancedImages => _enhancedImages;
  set enhancedImages(List<EnhancedVM> value) {
    _enhancedImages.clear();
    _enhancedImages.addAll(value);
    notifyListeners();
  }

  final List<FaceVM> _faces = [];
  List<FaceVM> get faces => _faces;
  set faces(List<FaceVM> value) {
    _faces.clear();
    _faces.addAll(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _paintBefore.dispose();
    _paintAfter.dispose();
    super.dispose();
  }
}
