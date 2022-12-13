import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeholder;
  final Color? color;
  const CustomNetworkImage({
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: color,
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      // placeholder: (context, url) => Image.asset(
      //   AppAssets.instance.placeholder,
      //   height: height,
      //   width: width,
      //   fit: BoxFit.cover,
      // ),
      // errorWidget: (context, url, error) => Image.asset(
      //   placeholder ?? AppAssets.instance.placeholder,
      //   height: height,
      //   width: width,
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
