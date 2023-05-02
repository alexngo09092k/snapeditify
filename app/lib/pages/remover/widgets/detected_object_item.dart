import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/view_models/detected_object_vm.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/tile_row.dart';

class DetectedObjectItem extends ProviderStateless<IRemoverProvider> {
  DetectedObjectItem({super.key, required this.maskId});
  final int maskId;
  
  DetectedObjectVM get detectedObject => provider.state.detectedObjects[maskId]!;

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
    final actionWidget = PropConsumer<IRemoverProvider, bool>(
      select: (p) => detectedObject.isSelected,
      builder: (_, __, ___, isSelected) => Container(
        alignment: Alignment.center,
        child: isSelected
            ? CustomIcon(
                CupertinoIcons.check_mark_circled_solid,
                color: Theme.of(context).primaryColor,
              )
            : const CustomIcon(CupertinoIcons.circle),
      ),
    );
    final subTitle = Text(
      '${(double.parse(detectedObject.accuracy) * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
      style: Theme.of(context).textTheme.bodyMedium!,
    );
    final title = Text(
      detectedObject.objectDescription,
      style: Theme.of(context).textTheme.titleMedium,
    );
    final removeText = PropConsumer<IRemoverProvider, bool>(
      select: (p) => detectedObject.isRemoved,
      builder: (_, __, ___, isRemoved) => isRemoved
          ? Padding(
              padding: EdgeInsets.only(left: AppDimensions.instance.paddingX(0.5)),
              child: Container(
                padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.2)),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  S.of(context).removed,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error),
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
