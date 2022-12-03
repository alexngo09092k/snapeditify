import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/services/snap_edit/src/models/response/detected_object.dart';
import 'package:snapedit/pages/remove_object/widgets/detected_object_row.dart';

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
            // padding: const EdgeInsets.symmetric(vertical: AppDimensions.instance.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.instance.imgNoObjectsNormal3x,
                  width: 70,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: AppDimensions.instance.padding),
                Text(
                  S.of(context).noPotentialObjectHasBeenDetected,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).disabledColor),
                )
              ],
            ),
          );
  }
}
