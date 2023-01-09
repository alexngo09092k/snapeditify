import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/generated/l10n.dart';
import 'package:phosart/view_models/detected_object_vm.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';
import 'package:phosart/widgets/base/tile_row.dart';

class DetectedObjectItem extends StatelessWidget {
  const DetectedObjectItem({Key? key, required this.detectedObject, required this.provider}) : super(key: key);
  final DetectedObjectVM detectedObject;
  final RemoveObjectProvider provider;

  _onTap(_) {
    provider.state.detectedObjects.firstWhere((element) => element.maskId == detectedObject.maskId).toggleSelection();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: detectedObject.image != null ? Image.memory(base64.decode(detectedObject.image!)) : const SizedBox(),
        ),
      ),
    );
    final actionWidget = BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects.firstWhere((element) => element.maskId == detectedObject.maskId).isSelected,
      builder: (_, __, p, isSelected) {
        return Container(
          alignment: Alignment.center,
          child: Image.asset(
            (isSelected ?? false) ? AppAssets.instance.icCheckboxSelected : AppAssets.instance.icCheckbox,
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
        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.red),
      ),
    );
    return BasePropConsumer<RemoveObjectProvider, bool>(
      listenable: provider,
      select: (p) => p.state.detectedObjects.firstWhere((element) => element.maskId == detectedObject.maskId).isRemoved,
      builder: (_, __, p, isRemoved) => TileRow(
        onTap: _onTap,
        leading: imageWidget,
        main: Column(
          children: [
            Row(children: [title, if (isRemoved ?? false) removeText]),
            subTitle
          ],
        ),
        action: actionWidget,
      ),
    );
  }
}
