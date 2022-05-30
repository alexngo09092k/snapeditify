import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';

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
                  width: 20,
                ),
                const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
                Text('${controller.state.detectedObjects.values.length} objects detected'),
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
