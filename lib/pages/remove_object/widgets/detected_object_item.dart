import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';
import 'package:phosart/view_models/detected_object_vm.dart';
import 'package:phosart/widgets/base/tile_row.dart';

class DetectedObjectItem extends StatelessWidget {
  const DetectedObjectItem({Key? key, required this.detectedObject, required this.provider}) : super(key: key);
  final DetectedObjectVM detectedObject;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        color: Theme.of(context).disabledColor,
        width: AppDimensions.instance.iconX(2),
        height: AppDimensions.instance.iconX(2),
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
        child: Image.asset(
          p.state.detectedObjects[detectedObject.maskId]!.isSelected ? AppAssets.instance.icCheckboxSelected : AppAssets.instance.icCheckbox,
          width: 30,
        ),
      ),
    );
    final subTitle = Text(
      '${(double.parse(detectedObject.accuracy) * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
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
                  S.of(context).removed,
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
