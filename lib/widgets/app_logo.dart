import 'package:flutter/material.dart';
import 'package:snapedit/common/configuration.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key, this.image, this.width, this.height, this.color})
      : super(key: key);
  final String? image;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image ?? Cofiguration.appLogo,
      width: width,
      height: height,
      color: color,
    );
  }
}
