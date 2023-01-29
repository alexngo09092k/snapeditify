import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/albums/widgets/album_item.dart';
import 'package:snapeditify/pages/albums/widgets/suggested_item.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({super.key, required this.provider});
  final GalleryProvider provider;

  @override
  Widget build(BuildContext context) {
    final spacing = AppDimensions.instance.padding;
    final double itemWidth = (AwesomeAppState.screen.width - spacing * 5) * 1 / 2;
    return Expanded(
      child: BasePropConsumer<GalleryProvider, int>(
        listenable: provider,
        select: (_) => _.albumList.length + 1,
        builder: (_, __, p, ___) => GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: spacing * 2,
          mainAxisSpacing: spacing * 2,
          padding: EdgeInsets.only(left: spacing, right: spacing * 2),
          childAspectRatio: itemWidth / (itemWidth + spacing * 3),
          children: [
            SuggestedItem(
              provider: provider,
              width: itemWidth,
              height: itemWidth,
            ),
            ...p.albumList
                .map((e) => AlbumItem(
                      album: e,
                      provider: provider,
                      width: itemWidth,
                      height: itemWidth,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
