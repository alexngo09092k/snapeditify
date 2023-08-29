import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MaskedImage extends StatelessWidget {
  final Uint8List asset;
  final Uint8List mask;

  const MaskedImage({super.key, required this.asset, required this.mask});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<ShaderMask?>(
          future: MaskedImage.createShaderMask(
            asset,
            mask,
            constraints.maxWidth,
            constraints.maxHeight,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            return snapshot.data!;
          },
        );
      },
    );
  }

  static Future<ShaderMask?> createShaderMask(
    Uint8List asset,
    Uint8List mask,
    double w,
    double h,
  ) async {
    try {
      Codec codec = await instantiateImageCodec(
        mask,
        targetWidth: w.toInt(),
        targetHeight: h.toInt(),
      );
      FrameInfo fi = await codec.getNextFrame();

      ImageShader shader = ImageShader(
        fi.image,
        TileMode.clamp,
        TileMode.clamp,
        Matrix4.identity().storage,
      );
      Image image = Image.memory(
        asset,
        fit: BoxFit.cover,
        width: w,
        height: h,
      );
      return ShaderMask(
        blendMode: BlendMode.dstATop,
        shaderCallback: (rect) => shader,
        child: image,
      );
    } catch (_) {
      return null;
    }
  }
}
