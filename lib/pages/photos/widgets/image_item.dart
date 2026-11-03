import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:snapeditify/common/constants.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({super.key, this.size, this.onPhoto, this.child});

  final Function()? onPhoto;
  final Size? size;
  final Widget? child;

  /// Lấy bytes ảnh ổn định trên Google + Huawei (EMUI/HarmonyOS).
  /// Trên Huawei `asset.file` hay trả null → fallback originFile / originBytes.
  static Future<Uint8List?> loadAssetBytes(AssetEntity assetEntity) async {
    try {
      // 1) File path thông thường
      final File? file = await assetEntity.file;
      if (file != null && await file.exists()) {
        return file.readAsBytesSync();
      }
    } catch (_) {}

    try {
      // 2) Origin file (Huawei / scoped storage hay cần)
      final File? origin = await assetEntity.originFile;
      if (origin != null && await origin.exists()) {
        return origin.readAsBytesSync();
      }
    } catch (_) {}

    try {
      // 3) Bytes trực tiếp từ MediaStore
      final Uint8List? bytes = await assetEntity.originBytes;
      if (bytes != null && bytes.isNotEmpty) return bytes;
    } catch (_) {}

    try {
      // 4) Thumbnail chất lượng cao (last resort để vẫn vào được editor)
      final Uint8List? thumb = await assetEntity.thumbnailDataWithSize(
        const ThumbnailSize(2000, 2000),
        quality: 95,
      );
      if (thumb != null && thumb.isNotEmpty) return thumb;
    } catch (_) {}

    return null;
  }

  factory ImageItem.withAssetEntity(
    AssetEntity assetEntity, {
    Size? size,
    Function(Uint8List bytes)? onImage,
  }) {
    final r = AppDimensions.instance.radiusX(0.7);
    return ImageItem(
      size: size,
      onPhoto: () async {
        if (onImage == null) return;
        final Uint8List? bytes = await loadAssetBytes(assetEntity);
        if (bytes != null) {
          onImage(bytes);
        }
      },
      child: Container(
        width: size?.width,
        height: size?.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: AssetEntityImage(
                assetEntity,
                thumbnailSize: size != null
                    ? ThumbnailSize(size.width.toInt(), size.height.toInt())
                    : null,
                fit: BoxFit.cover,
                isOriginal: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory ImageItem.withAsset(
    String photo, {
    Size? size,
    Function(Uint8List bytes)? onImage,
  }) {
    final r = AppDimensions.instance.radiusX(0.7);
    return ImageItem(
      size: size,
      onPhoto: () async {
        final Uint8List bytes =
            (await rootBundle.load(photo)).buffer.asUint8List();
        if (onImage != null) onImage(bytes);
      },
      child: Container(
        width: size?.width,
        height: size?.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
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
