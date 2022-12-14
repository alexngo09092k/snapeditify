import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/models/ai_detection_handler.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/widgets/base/tile_row.dart';

class DetectedObjectItem extends StatelessWidget {
  const DetectedObjectItem({Key? key, required this.detectedObject, required this.provider}) : super(key: key);
  final DetectedObjectHandler detectedObject;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: detectedObject.image != null
              ? Image.memory(
                  base64.decode(detectedObject.image!),
                )
              : const SizedBox(),
        ),
      ),
    );
    final actionWidget = BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects[detectedObject.maskId]!.isSelected,
      builder: (_, __, p, ___) {
        return Container(
          alignment: Alignment.center,
          child: Image.asset(
            detectedObject.isSelected ? AppAssets.instance.icCheckboxSelected : AppAssets.instance.icCheckbox,
            width: 30,
          ),
        );
      },
    );
    final subTitle = Text(
      '${(double.parse(detectedObject.accuracy) * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
      style: Theme.of(context).textTheme.bodyText2!,
    );
    final title = Text(
      detectedObject.objectDescription,
      style: Theme.of(context).textTheme.subtitle1,
    );
    final removeText = Container(
      padding: EdgeInsets.all(AppDimensions.instance.paddingX(1)),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        S.of(context).removed,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.red,
            ),
      ),
    );
    return BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects[detectedObject.maskId]?.isRemoved ?? false,
      builder: (_, __, p, ___) => TileRow(
        leading: imageWidget,
        main: Column(
          children: [
            Row(children: [title, if (p.state.detectedObjects[detectedObject.maskId]?.isRemoved ?? false) removeText]),
            subTitle
          ],
        ),
        action: actionWidget,
      ),
    );
  }
}
