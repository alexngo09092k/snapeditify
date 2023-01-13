import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/provider/widgets/autopplistener.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/pages/gallery/widgets/album_image.dart';
import 'package:phosart/providers/gallery/gallery_provider.dart';

class TrySuggestedImages extends StatelessWidget {
  const TrySuggestedImages({super.key, required this.gridDelegate, required this.size, this.onImage});
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final Size size;
  final Function(Uint8List, ImageSource)? onImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          child: Row(
            children: [
              Text('Try suggested images', style: Theme.of(context).textTheme.bodyText1),
              Image.asset(
                AppAssets.instance.icStar,
                width: AppDimensions.instance.icon,
              )
            ],
          ),
        ),
        PropConsumer<GalleryProvider, EditImageType>(
          select: (_) => _.editImageType,
          builder: (_, __, p, ___) => Wrap(
            spacing: gridDelegate.mainAxisSpacing,
            runSpacing: gridDelegate.crossAxisSpacing,
            children: p.suggestedPhotos.map((e) => AlbumImage.withAsset(e, size: size, onImage: onImage)).toList(),
          ),
        )
      ],
    );
  }
}
