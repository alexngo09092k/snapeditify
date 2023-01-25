import 'package:flutter/material.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_after.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_before.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/widgets/base/base_image_editor.dart';
import 'package:snapeditify/widgets/before_after/before_after.dart';

class EnhanceImage extends StatelessWidget {
  const EnhanceImage({Key? key, required this.provider}) : super(key: key);
  final EnhanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      background: Colors.transparent,
      builder: (width, height) => BeforeAfter(
        beforeImage: EnhanceBefore(provider: provider),
        afterImage: EnhanceAfter(provider: provider),
        imageWidth: width,
        imageHeight: height,
      ),
    );
  }
}
