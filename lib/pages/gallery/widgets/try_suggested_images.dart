import 'package:flutter/material.dart';
import 'package:fluttering/provider/widgets/autopplistener.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/gallery/widgets/album_photo.dart';
import 'package:snapedit/providers/gallery_provider.dart';

class TrySuggestedImages extends StatelessWidget {
  const TrySuggestedImages({super.key, required this.gridDelegate, required this.size, this.onPhoto});
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final Size size;
  final Function(String, PhotosType)? onPhoto;

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
        PropConsumer<GalleryProvider, PhotosFor>(
          select: (_) => _.photosFor,
          builder: (_, __, p, ___) => Wrap(
            spacing: gridDelegate.mainAxisSpacing,
            runSpacing: gridDelegate.crossAxisSpacing,
            children: p.suggestedPhotos.map((e) => AlbumPhoto.withAsset(e, size: size, onPhoto: onPhoto)).toList(),
          ),
        )
      ],
    );
  }
}
