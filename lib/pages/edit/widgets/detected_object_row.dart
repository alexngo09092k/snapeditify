import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/generated/l10n.dart';

class DetectedObjectRow extends StatelessWidget {
  const DetectedObjectRow({
    Key? key,
    required this.maskId,
    required this.controller,
  }) : super(key: key);

  final int maskId;
  final EditController controller;

  @override
  Widget build(BuildContext context) {
    final Widget title = Text(controller.detectedObjects[maskId]!.objectDescription);
    late final Widget subTitle = Text('${(controller.detectedObjects[maskId]!.accuracy * 100).toStringAsFixed(2)} ${S.of(context).accurate}');
    late final Widget remove = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.kRedColorHeart.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
      child: Text(
        S.of(context).removed,
        style: const TextStyle(color: AppColors.kRedColorHeart, fontSize: 12),
      ),
    );

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, __, image) => Container(
        color: controller.detectedObjects[maskId]!.isSelected && !controller.detectedObjects[maskId]!.isRemoved
            ? Theme.of(context).disabledColor.withOpacity(0.1)
            : Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSizeDefault),
          onTap: () {
            if (controller.detectedObjects[maskId]!.isRemoved) {
              return;
            }
            if (controller.detectedObjects[maskId]!.isSelected) {
              controller.unSelectedDtectedObjects(controller.detectedObjects[maskId]!.maskId);
            } else {
              controller.selectedDetectedObjects(controller.detectedObjects[maskId]!.maskId);
            }
          },
          leading: image,
          title: title,
          subtitle: Row(
            children: [
              subTitle,
              const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
              controller.detectedObjects[maskId]!.isRemoved ? remove : const SizedBox()
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                controller.detectedObjects[maskId]!.isSelected || controller.detectedObjects[maskId]!.isRemoved
                    ? AppImages.icCheckboxSelectedNormal3x
                    : AppImages.icCheckboxNormalNormal3x,
                width: 20,
              ),
              const SizedBox(height: AppDimensions.paddingSizeExtraSmall)
            ],
          ),
        ),
      ),
      child: controller.detectedObjects[maskId]!.image != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).disabledColor),
                width: 50,
                height: 50,
                child: Center(
                  child: Image.memory(
                    base64.decode(controller.detectedObjects[maskId]!.image!),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            )
          : const SizedBox(width: 50),
    );
  }
}
