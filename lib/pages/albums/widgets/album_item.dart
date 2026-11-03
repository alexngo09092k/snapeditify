import 'dart:math';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/view_models/album_vm.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({super.key, required this.album, this.width, this.height});
  final AlbumVM album;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = AppDimensions.instance.radius;

    return GestureDetector(
      onTap: () => AppRoutes.instance.goPhotosPage(context, albumId: album.entityPath.id),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Soft stacked cards behind
              Transform.translate(
                offset: const Offset(7, 7),
                child: Transform.rotate(
                  angle: -pi / 36,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(r),
                      color: isDark
                          ? Colors.white.withOpacity(0.04)
                          : const Color(0xFFE8EAF2),
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(3.5, 3.5),
                child: Transform.rotate(
                  angle: -pi / 70,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(r),
                      color: isDark
                          ? Colors.white.withOpacity(0.07)
                          : const Color(0xFFF0F2F8),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFE4E7F0),
                      ),
                    ),
                  ),
                ),
              ),
              AppCard(
                width: width,
                height: height,
                borderRadius: BorderRadius.circular(r),
                child: album.thumnail != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(r - 1),
                        child: PropConsumer<IGalleryProvider, AssetEntity?>(
                          select: (_) => _.albumList[album.entityPath.id]!.thumnail,
                          builder: (_, __, ___, thumnail) => AssetEntityImage(
                            width: width,
                            height: height,
                            thumnail!,
                            fit: BoxFit.cover,
                            isOriginal: true,
                          ),
                        ),
                      )
                    : ImagePlaceholder(
                        width: width,
                        height: height,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          PropConsumer<IGalleryProvider, int>(
            select: (_) => _.albumList[album.entityPath.id]!.count,
            builder: (_, __, ___, length) => Text(
              '${album.entityPath.name} ($length)',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                    color: isDark
                        ? Colors.white.withOpacity(0.88)
                        : const Color(0xFF2D3348),
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
