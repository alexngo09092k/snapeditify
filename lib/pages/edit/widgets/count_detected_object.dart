// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/edit_provider/edit_provider.dart';

class CountDetectedObject extends StatelessWidget {
  CountDetectedObject({
    Key? key,
    required this.showDetailDetectedObject,
  }) : super(key: key);

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
                  AppImages.instance.icGroupsNormal3x,
                  width: 25,
                ),
                SizedBox(width: AppDimensions.instance.paddingSizeExtraSmall),
                Text(
                  S.of(context).showAllObjects,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    AppDimensions.instance.paddingSizeExtraSmall,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppDimensions.instance.paddingSizeDefault / 2,
                      ),
                    ),
                    gradient: AppColors.instance.gradient,
                  ),
                  child: Center(
                    child: PropConsumer<EditProvider, int>(
                      select: (p) => p.state.detectedObjects.values.length,
                      builder: (_, __, p, ___) => Text(
                        '${p.state.detectedObjects.values.length}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppColors.instance.kWhite,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppDimensions.instance.paddingSizeExtraSmall,
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
