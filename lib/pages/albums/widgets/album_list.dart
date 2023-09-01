import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/albums/widgets/album_item.dart';
import 'package:snapeditify/pages/albums/widgets/suggested_item.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = AppDimensions.instance.padding;
    final double itemWidth = (AwesomeAppState.screen.width - spacing * 5) * 1 / 2;
    return Expanded(
      child: PropConsumer<IGalleryProvider, int>(
        select: (_) => _.albumList.length + 1,
        builder: (_, __, p, ___) => GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: spacing * 2,
          mainAxisSpacing: spacing,
          padding: EdgeInsets.only(left: spacing, right: spacing * 2),
          childAspectRatio: itemWidth / (itemWidth + spacing * 3),
          children: [
            if (p.suggestedPhotos.isNotEmpty)
              SuggestedItem(
                image: p.suggestedPhotos[0],
                total: p.suggestedPhotos.length,
                width: itemWidth,
                height: itemWidth,
              ),
            ...p.albumList.values
                .map((e) => AlbumItem(
                      album: e,
                      width: itemWidth,
                      height: itemWidth,
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
