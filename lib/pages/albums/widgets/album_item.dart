import 'dart:math';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class AlbumItem extends StatefulWidget {
  const AlbumItem({super.key, required this.album, this.width, this.height});
  final AssetPathEntity album;
  final double? width;
  final double? height;

  @override
  State<AlbumItem> createState() => _AlbumItemState();
}

class _AlbumItemState extends State<AlbumItem> {
  final List<AssetEntity> _assetEntities = [];

  @override
  void initState() {
    _initial();
    super.initState();
  }

  _initial() async {
    _assetEntities.addAll(await widget.album.getAssetListPaged(page: 0, size: 2));
    setState(() {});
  }

  _onAlbum() {
    AppRoutes.instance.goPhotosPage(context, album: widget.album);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onAlbum,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(8, 8),
                child: Transform.rotate(
                  angle: -pi / 30,
                  child: AppCard(width: widget.width, height: widget.height),
                ),
              ),
              Transform.translate(
                offset: const Offset(4, 4),
                child: Transform.rotate(
                  angle: -pi / 60,
                  child: AppCard(width: widget.width, height: widget.height),
                ),
              ),
              AppCard(
                width: widget.width,
                height: widget.height,
                child: _assetEntities.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                        child: AssetEntityImage(
                          width: widget.width,
                          height: widget.height,
                          _assetEntities[0],
                          fit: BoxFit.cover,
                        ),
                      )
                    : CustomImage(image: AppAssets.instance.icImagePlaceholder),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.paddingX(1.5)),
          FutureBuilder(
            future: widget.album.assetCountAsync,
            builder: (_, snap) => Text(
              '${widget.album.name} (${snap.data.toString()})',
              style: Theme.of(context).textTheme.bodyText1!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
