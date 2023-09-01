import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({super.key, this.size, this.onPhoto, this.child});

  final Function()? onPhoto;

  final Size? size;
  final Widget? child;

  factory ImageItem.withAssetEntity(AssetEntity assetEntity, {Size? size, Function(Uint8List bytes)? onImage}) {
    return ImageItem(
        size: size,
        onPhoto: () async {
          File? file = (await assetEntity.file);
          if (file != null && onImage != null) {
            onImage(file.readAsBytesSync());
          }
        },
        child: SizedBox(
          width: size?.width,
          height: size?.height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: AssetEntityImage(
                  assetEntity,
                  thumbnailSize: size != null ? ThumbnailSize(size.width.toInt(), size.height.toInt()) : null,
                  fit: BoxFit.cover,
                  // isOriginal: false,
                ),
              ),
            ],
          ),
        ));
  }

  factory ImageItem.withAsset(String photo, {Size? size, Function(Uint8List bytes)? onImage}) {
    return ImageItem(
      size: size,
      onPhoto: () async {
        Uint8List bytes = (await rootBundle.load(photo)).buffer.asUint8List();
        if (onImage != null) onImage(bytes);
      },
      child: SizedBox(
        width: size?.width,
        height: size?.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                photo,
                width: size?.width,
                height: size?.height,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPhoto,
      child: child,
    );
  }
}
