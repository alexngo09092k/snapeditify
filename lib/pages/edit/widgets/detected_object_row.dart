import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/models/detected_object.dart';
import 'package:snapedit/providers/edit_provider/edit_provider.dart';

class DetectedObjectRow extends StatelessWidget {
  const DetectedObjectRow({
    Key? key,
    required this.maskId,
  }) : super(key: key);

  final int maskId;

  @override
  Widget build(BuildContext context) {
    EditProvider p = ManagerProvider.of<EditProvider>();
    if (p.detectedObjects[maskId] == null) {
      return const SizedBox();
    }

    final Widget title = Text(
      p.detectedObjects[maskId]!.objectDescription,
      style: Theme.of(context).textTheme.subtitle1,
    );
    late final Widget subTitle = Text(
      '${(p.detectedObjects[maskId]!.accuracy * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
    late final Widget remove = Container(
      padding: EdgeInsets.all(AppDimensions.instance.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: AppColors.instance.kRed.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        S.of(context).removed,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppColors.instance.kRed,
            ),
      ),
    );

    var detectedObject = p.detectedObjects[maskId];

    return PropConsumer<EditProvider, DetectedObject?>(
      select: (p) => p.detectedObjects[maskId],
      builder: (_, child, ___, object) => detectedObject != null
          ? Container(
              color: detectedObject.isSelected && detectedObject.isRemoved ? Theme.of(context).highlightColor.withOpacity(0.1) : Colors.transparent,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingSizeDefault),
                onTap: () {
                  if (detectedObject.isRemoved) {
                    return;
                  }
                  if (detectedObject.isSelected) {
                    p.unSelectedDtectedObjects(detectedObject.maskId);
                  } else {
                    p.selectedDetectedObjects(detectedObject.maskId);
                  }
                },
                leading: child,
                title: title,
                subtitle: Row(
                  children: [
                    subTitle,
                    SizedBox(width: AppDimensions.instance.paddingSizeExtraSmall),
                    detectedObject.isRemoved ? remove : const SizedBox()
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      detectedObject.isSelected || detectedObject.isRemoved
                          ? AppImages.instance.icCheckboxSelectedNormal3x
                          : AppImages.instance.icCheckboxNormalNormal3x,
                      width: 30,
                    ),
                    SizedBox(height: AppDimensions.instance.paddingSizeExtraSmall)
                  ],
                ),
              ),
            )
          : const SizedBox(),
      child: detectedObject != null && detectedObject.image != null
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
                      detectedObject.image!,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(width: 50),
    );
  }
}
