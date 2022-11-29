import 'package:flutter/material.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/widgets/custom_network_image.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Configuration.instance.isNetwork(image)
        ? CustomNetworkImage(
            image: image,
            width: width,
            height: height,
            color: color,
            fit: fit,
          )
        : Image.asset(
            image,
            width: width,
            height: height,
            color: color,
            fit: fit,
          );
  }
}
