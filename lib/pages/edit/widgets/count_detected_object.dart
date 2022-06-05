import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';

class CountDetectedObject extends StatelessWidget {
  CountDetectedObject({
    Key? key,
    required this.controller,
    required this.showDetailDetectedObject,
  }) : super(key: key);

  final EditController controller;
  void Function() showDetailDetectedObject;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: showDetailDetectedObject,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  AppImages.icGroupsNormal3x,
                  width: 25,
                ),
                const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
                Text(
                  '${controller.state.detectedObjects.values.length} ${S.of(context).objectsDetected}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          ],
        ));
  }
}
