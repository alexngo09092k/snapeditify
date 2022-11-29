import 'package:flutter/material.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/widgets/custom_image.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, this.image, this.width, this.height, this.color})
      : super(key: key);
  final String? image;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimensions.instance.paddingSizeSmall),
      ),
      child: CustomImage(
        image: image ?? Configuration.instance.appConfig.appLogo,
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
