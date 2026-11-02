import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
    this.placeholder,
  });
  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return Configuration.instance.isNetwork(image)
        ? CachedNetworkImage(
            imageUrl: image,
            width: width,
            height: height,
            color: color,
            fit: fit,
            placeholder: (_, __) => ImagePlaceholder(
              width: width,
              height: height,
              placeHolder: placeholder,
            ),
            errorWidget: (_, __, ___) => ImagePlaceholder(
              width: width,
              height: height,
              placeHolder: placeholder,
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

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.placeHolder,
  });
  final double? width;
  final double? height;
  final String? placeHolder;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      placeHolder ?? AppAssets.instance.imagePlaceholder,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
