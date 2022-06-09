import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';

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
    if (controller.detectedObjects[maskId] == null) {
      return const SizedBox();
    }

    final Widget title = Text(
      controller.detectedObjects[maskId]!.objectDescription,
      style: Theme.of(context).textTheme.subtitle1,
    );
    late final Widget subTitle = Text(
      '${(controller.detectedObjects[maskId]!.accuracy * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
    late final Widget remove = Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: AppColors.kRedColorHeart.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        S.of(context).removed,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppColors.kRedColorHeart,
            ),
      ),
    );

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, __, image) => Container(
        color: controller.detectedObjects[maskId]!.isSelected &&
                !controller.detectedObjects[maskId]!.isRemoved
            ? Theme.of(context).highlightColor.withOpacity(0.1)
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                controller.detectedObjects[maskId]!.isSelected ||
                        controller.detectedObjects[maskId]!.isRemoved
                    ? AppImages.icCheckboxSelectedNormal3x
                    : AppImages.icCheckboxNormalNormal3x,
                width: 30,
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
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  // image: DecorationImage(
                  //   image: Image.memory(
                  //     base64.decode(
                  //       controller.detectedObjects[maskId]!.image!,
                  //     ),
                  //   ).image,
                  //   fit: BoxFit.fill,
                  //   opacity: 0.5,
                  // ),
                ),
                width: 60,
                height: 60,
                child: Center(
                  child: Image.memory(
                    base64.decode(
                      controller.detectedObjects[maskId]!.image!,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(width: 50),
    );
  }
}
