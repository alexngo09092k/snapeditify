import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/photos/widgets/image_item.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';

class SuggestedImageList extends StatelessWidget {
  const SuggestedImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return PropConsumer<GalleryProvider, EditImageType>(
      select: (_) => _.editImageType,
      builder: (_, __, p, ___) => Wrap(
        spacing: AppDimensions.instance.gridDelegate.mainAxisSpacing,
        runSpacing: AppDimensions.instance.gridDelegate.crossAxisSpacing,
        children: p.suggestedPhotos
            .map((e) => ImageItem.withAsset(
                  e,
                  size: AppDimensions.instance.gridItemSize,
                  onImage: (_) => AppRoutes.instance.goEditImagePage(context, bytes: _),
                ))
            .toList(),
      ),
    );
  }
}
