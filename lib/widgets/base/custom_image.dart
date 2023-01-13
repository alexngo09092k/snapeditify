import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';

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
        ? CachedNetworkImage(
            imageUrl: image,
            width: width,
            height: height,
            color: color,
            fit: fit,
            placeholder: (context, url) => Image.asset(
              AppAssets.instance.icImagePlaceholder,
              width: width,
              height: height,
              fit: fit,
            ),
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
