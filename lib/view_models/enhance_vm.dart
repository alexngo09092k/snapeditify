import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/services.dart';
import 'dart:ui' as ui;

import 'package:snapedit/utils/image.dart';

class EnhanceVM extends EnhanceResponse {
  EnhanceVM({
    required super.faces,
    required super.numFaceModels,
    required super.numTotalFaces,
    required super.outputImages,
  }) {
    _initial();
  }

  factory EnhanceVM.defaultValue() {
    return EnhanceVM(
      faces: [],
      numFaceModels: 0,
      numTotalFaces: 0,
      outputImages: [],
    );
  }

  factory EnhanceVM.fromEnhanceResponse(EnhanceResponse response) {
    return EnhanceVM(
      faces: response.faces,
      numFaceModels: response.numFaceModels,
      numTotalFaces: response.numTotalFaces,
      outputImages: response.outputImages,
    );
  }

  late final List<FaceVM> _facesHandler;
  List<FaceVM> get facesHandler => _facesHandler;

  Future<void> _initial() async {
    _facesHandler = faces.map((e) => FaceVM.fromFace(e)).toList();
  }
}

class FaceVM extends Face {
  FaceVM({required super.box, required super.faceId, required super.png});

  factory FaceVM.fromFace(Face face) {
    return FaceVM(box: face.box, faceId: face.faceId, png: face.png);
  }

  ui.Image? image;

  final Map<String, ui.Image> _enhancedImageList = {};

  Map<String, ui.Image> get enhancedImageList => _enhancedImageList;

  bool isSelected = false;

  @override
  FaceVM copyWith({
    List<int>? box,
    int? faceId,
    List<String>? png,
    bool? isSelected,
    ui.Image? image,
    Map<String, ui.Image>? enhancedImageList,
  }) {
    return FaceVM(
      box: box ?? this.box,
      faceId: faceId ?? this.faceId,
      png: png ?? this.png,
    )
      ..image = image ?? this.image
      ..enhancedImageList.addAll(enhancedImageList ?? this.enhancedImageList)
      ..isSelected = isSelected ?? this.isSelected;
  }

  Future<void> paintParse({
    required ui.Size realSize,
    required ui.Size viewSize,
    required String originalImageBase64,
    required List<String> enhancedImageBase64List,
  }) async {
    if (box.length > 3) {
      ui.Offset realBoxPosition = ui.Offset(box[0].toDouble(), box[1].toDouble());
      ui.Size realBoxSize = ui.Size((box[2] - box[0]).toDouble(), (box[3] - box[1]).toDouble());

      double ratioX = viewSize.width / realSize.width;
      double ratioY = viewSize.height / realSize.height;

      ui.Size size = ui.Size(realBoxSize.width * ratioX, realBoxSize.height * ratioY);
      ui.Offset position = ui.Offset(
        realBoxPosition.dx * ratioX + size.width / 2,
        realBoxPosition.dy * ratioX + size.height / 2,
      );

      Debug.log('paintParse $position');
      Debug.log('paintParse $size');

      image = await ImageUtils.instance.base64ToImageUI(
        await ImageUtils.instance.cropImageBase64(
          originalImageBase64,
          size: realBoxSize,
          position: realBoxPosition,
        ),
      );

      for (var enhancedImageBase64 in enhancedImageBase64List) {
        _enhancedImageList[enhancedImageBase64] = await ImageUtils.instance.base64ToImageUI(
          await ImageUtils.instance.cropImageBase64(
            enhancedImageBase64,
            size: realBoxSize,
            position: realBoxPosition,
          ),
        );
      }
    }
  }
}
