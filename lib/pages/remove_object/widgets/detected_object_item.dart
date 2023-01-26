import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/view_models/detected_object_vm.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/tile_row.dart';

class DetectedObjectItem extends StatelessWidget {
  const DetectedObjectItem({Key? key, required this.detectedObject, required this.provider}) : super(key: key);
  final DetectedObjectVM detectedObject;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
        width: AppDimensions.instance.iconX(1.5),
        height: AppDimensions.instance.iconX(1.5),
        child: Center(
          child: detectedObject.image != null ? Image.memory(base64.decode(detectedObject.image!)) : const SizedBox(),
        ),
      ),
    );
    final actionWidget = BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects[detectedObject.maskId]!.isSelected,
      builder: (_, __, p, ___) => Container(
        alignment: Alignment.center,
        child: p.state.detectedObjects[detectedObject.maskId]!.isSelected
            ? CustomIcon(
                CupertinoIcons.check_mark_circled_solid,
                color: Theme.of(context).primaryColor,
              )
            : const CustomIcon(CupertinoIcons.circle),
      ),
    );
    final subTitle = Text(
      '${(double.parse(detectedObject.accuracy) * 100).toStringAsFixed(2)} % accurate',
      style: Theme.of(context).textTheme.bodyText2!,
    );
    final title = Text(
      detectedObject.objectDescription,
      style: Theme.of(context).textTheme.subtitle1,
    );
    final removeText = BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects[detectedObject.maskId]!.isRemoved,
      builder: (_, __, p, ___) => p.state.detectedObjects[detectedObject.maskId]!.isRemoved
          ? Padding(
              padding: EdgeInsets.only(left: AppDimensions.instance.paddingX(0.5)),
              child: Container(
                padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.2)),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  'Remove',
                  style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),
                ),
              ),
            )
          : const SizedBox(),
    );
    return TileRow(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.instance.paddingX(0.5),
        horizontal: AppDimensions.instance.padding,
      ),
      onTap: (_) => detectedObject.toggleSelection(),
      leading: imageWidget,
      main: Padding(
        padding: EdgeInsets.only(left: AppDimensions.instance.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [title, removeText],
            ),
            SizedBox(height: AppDimensions.instance.paddingX(0.5)),
            subTitle
          ],
        ),
      ),
      action: actionWidget,
    );
  }
}
