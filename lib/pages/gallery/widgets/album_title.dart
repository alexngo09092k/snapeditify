import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:snapedit/common/constants.dart';

class AlbumTitle extends StatelessWidget {
  const AlbumTitle({super.key, required this.album, required this.total});

  final AssetPathEntity album;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Row(
        children: [
          Text(album.name, style: Theme.of(context).textTheme.bodyText1),
          SizedBox(width: AppDimensions.instance.paddingX(0.2)),
          Container(
              padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.2)),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.instance.radiusX(0.5)),
                ),
              ),
              child: Text(
                total.toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
