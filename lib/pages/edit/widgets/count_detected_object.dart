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
                  S.of(context).showAllObjects,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    AppDimensions.paddingSizeExtraSmall,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          AppDimensions.paddingSizeDefault / 2,
                        ),
                      ),
                      gradient: AppColors.gradient),
                  child: Center(
                    child: Text(
                      '${controller.state.detectedObjects.values.length}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColors.kWhite,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.paddingSizeExtraSmall,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                )
              ],
            )
          ],
        ));
  }
}
