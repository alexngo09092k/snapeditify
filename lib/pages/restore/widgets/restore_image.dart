import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/restore/widgets/restore_after.dart';
import 'package:snapeditify/pages/restore/widgets/restore_before.dart';
import 'package:snapeditify/widgets/app_use/base_image_editor.dart';
import 'package:snapeditify/widgets/app_use/before_after/before_after.dart';

class RestoreImage extends StatelessWidget {
  const RestoreImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseImageEditor(
      builder: (width, height) => BeforeAfter(
        beforeImage: const RestoreBefore(),
        afterImage: const RestoreAfter(),
        imageWidth: width,
        imageHeight: height,
        thumbImage: Image.asset(AppAssets.instance.icSeekbarThumb).image,
        thumbRadius: 0,
      ),
    );
  }
}
