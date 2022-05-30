import 'package:snapedit/common/app_config.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, this.image, this.width, this.height, this.color})
      : super(key: key);
  final String? image;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    String _image = image ?? AppConfig.appLogo;
    return Image.asset(
      _image,
      width: width,
      height: height,
      color: color,
    );
  }
}
