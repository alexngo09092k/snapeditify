import 'package:flutter/material.dart';
import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/custom_image.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, this.image, this.width, this.height, this.color}) : super(key: key);
  final String? image;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimensions.instance.paddingX(0.5)),
      ),
      child: CustomImage(
        image: image ?? Configuration.instance.businessConfig.appLogo,
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
