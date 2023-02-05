import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class SuggestedItem extends StatelessWidget {
  const SuggestedItem({super.key, required this.provider, this.width, this.height});
  final double? width;
  final double? height;
  final GalleryProvider provider;

  _onAlbum(BuildContext context) {
    AppRoutes.instance.goPhotosPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAlbum(context),
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
                color: Colors.yellow,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                  child: CustomImage(image: provider.suggestedPhotos[0]),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.paddingX(1.5)),
          Text(
            '${S.of(context).sugessted} (${provider.suggestedPhotos.length})',
            style: Theme.of(context).textTheme.bodyLarge!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
