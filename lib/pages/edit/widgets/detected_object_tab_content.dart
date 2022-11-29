import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/models/detected_object.dart';
import 'package:snapretouch/pages/edit/widgets/detected_object_row.dart';

class DetectedObjectTabContent extends StatelessWidget {
  const DetectedObjectTabContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<DetectedObject> data;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) => DetectedObjectRow(
              maskId: data.elementAt(index).maskId,
            ),
          )
        : SingleChildScrollView(
            // padding: const EdgeInsets.symmetric(vertical: AppDimensions.instance.paddingSizeDefault),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.instance.imgNoObjectsNormal3x,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: AppDimensions.instance.paddingSizeDefault),
                Text(
                  S.of(context).noPotentialObjectHasBeenDetected,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).disabledColor),
                )
              ],
            ),
          );
  }
}
