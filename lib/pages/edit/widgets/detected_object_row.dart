import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';

class DetectedObjectRow extends StatelessWidget {
  DetectedObjectRow({
    Key? key,
    required this.maskId,
    required this.controller,
  }) : super(key: key) {
    title = Text(controller.detectedObjects[maskId]!.objectDescription);
    subTitle =
        Text('${(controller.detectedObjects[maskId]!.accuracy * 100).toStringAsFixed(2)}% accurate');
    remove = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.red.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
      child: const Text(
        'Removed',
        style: TextStyle(color: AppColors.red, fontSize: 12),
      ),
    );
  }

  final int maskId;
  final EditController controller;
  late final Widget title;
  late final Widget subTitle;
  late final Widget remove;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      child: controller.detectedObjects[maskId]!.image != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor,
                ),
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
      valueListenable: controller,
      builder: (_, __, image) => Container(
        color: controller.detectedObjects[maskId]!.isSelected &&
                !controller.detectedObjects[maskId]!.isRemoved
            ? Theme.of(context).disabledColor.withOpacity(0.1)
            : Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSizeDefault),
          onTap: () {
            if (controller.detectedObjects[maskId]!.isRemoved) {
              return;
            }
            if (controller.detectedObjects[maskId]!.isSelected) {
              controller.unSelectedDtectedObjects(
                  controller.detectedObjects[maskId]!.maskId);
            } else {
              controller.selectedDetectedObjects(
                  controller.detectedObjects[maskId]!.maskId);
            }
          },
          leading: image,
          title: title,
          subtitle: Row(
            children: [
              subTitle,
              const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
              controller.detectedObjects[maskId]!.isRemoved
                  ? remove
                  : const SizedBox()
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                controller.detectedObjects[maskId]!.isSelected ||
                        controller.detectedObjects[maskId]!.isRemoved
                    ? AppImages.icCheckboxSelectedNormal3x
                    : AppImages.icCheckboxNormalNormal3x,
                width: 20,
              ),
              const SizedBox(
                height: AppDimensions.paddingSizeExtraSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
