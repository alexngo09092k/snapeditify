// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/providers/gallery_provider.dart';

class AlbumPhoto extends StatelessWidget {
  const AlbumPhoto({super.key, this.size, this.onPhoto, this.child});

  final Function()? onPhoto;

  final Size? size;
  final Widget? child;

  factory AlbumPhoto.withAssetEntity(AssetEntity photo, {Size? size, Function(String? photo, PhotosType type)? onPhoto}) {
    return AlbumPhoto(
        size: size,
        onPhoto: () async {
          if (onPhoto != null) onPhoto((await photo.file)?.path, PhotosType.inAlbum);
        },
        child: SizedBox(
          width: size?.width,
          height: size?.height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: AssetEntityImage(
                  photo,
                  isOriginal: false,
                  thumbnailSize: size != null ? ThumbnailSize(size.width.toInt(), size.height.toInt()) : null,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }

  factory AlbumPhoto.withAsset(String photo, {Size? size, Function(String path, PhotosType type)? onPhoto}) {
    return AlbumPhoto(
      size: size,
      onPhoto: () async {
        if (onPhoto != null) onPhoto(photo, PhotosType.inSuggesstedPhotos);
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
