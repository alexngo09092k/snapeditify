import 'dart:math';

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
  const AlbumItem({super.key, required this.album, this.width, this.height, required this.provider});
  final AlbumVM album;
  final double? width;
  final double? height;
  final GalleryProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.instance.goPhotosPage(context, albumId: album.entityPath.id),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(8, 8),
                child: Transform.rotate(
                  angle: -pi / 30,
                  child: AppCard(width: width, height: height),
                ),
              ),
              Transform.translate(
                offset: const Offset(4, 4),
                child: Transform.rotate(
                  angle: -pi / 60,
                  child: AppCard(width: width, height: height),
                ),
              ),
              AppCard(
                width: width,
                height: height,
                child: album.thumnail != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                        child: BasePropConsumer<GalleryProvider, AssetEntity?>(
                          listenable: provider,
                          select: (_) => _.albumList[album.entityPath.id]!.thumnail,
                          builder: (_, __, ___, thumnail) => AssetEntityImage(
                            width: width,
                            height: height,
                            thumnail!,
                            fit: BoxFit.cover,
                            isOriginal: false,
                          ),
                        ),
                      )
                    : CustomImage(image: AppAssets.instance.icImagePlaceholder),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.paddingX(1.5)),
          BasePropConsumer<GalleryProvider, int>(
            listenable: provider,
            select: (_) => _.albumList[album.entityPath.id]!.count,
            builder: (_, __, ___, length) => Text(
              '${album.entityPath.name} ($length)',
              style: Theme.of(context).textTheme.bodyLarge!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
