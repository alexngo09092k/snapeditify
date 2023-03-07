import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_after.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_before.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/before_after/before_after.dart';

class EnhanceImage extends StatelessWidget {
  const EnhanceImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => BeforeAfter(
        beforeImage: const EnhanceBefore(),
        afterImage: const EnhanceAfter(),
        imageWidth: width,
        imageHeight: height,
        thumbImage: Image.asset(AppAssets.instance.icSeekbarThumb).image,
        thumbRadius: 0,
      ),
    );
  }
}
