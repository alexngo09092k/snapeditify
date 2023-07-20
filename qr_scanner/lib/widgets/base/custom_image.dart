import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/common/configuration.dart';
import 'package:qr_scanner/common/constants.dart';

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
            placeholder: (_, __) => ImagePlaceholder(
              width: width,
              height: height,
            ),
            errorWidget: (_, __, ___) => ImagePlaceholder(
              width: width,
              height: height,
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
  const ImagePlaceholder({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.instance.imagePlaceholder,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
