import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/remove_object/widgets/detected_object_item.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/services/snap_edit/snap_edit.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class DetectedObjectList extends StatelessWidget {
  const DetectedObjectList({super.key, required this.type, required this.provider});

  final DetectedObjectType type;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return PropConsumer<IRemoveObjectProvider, int>(
      select: (p) => p.state.detectedObjects.length,
      builder: (_, __, p, ___) {
        final data = p.state.detectedObjects.values.where((detectedObject) => detectedObject.objectType == type);
        return data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) => DetectedObjectItem(
                  key: Key('$index'), 
                  maskId: data.elementAt(index).maskId,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImage(
                      image: AppAssets.instance.notFoundObject,
                      width: AppDimensions.instance.iconX(3),
                    ),
                    SizedBox(height: AppDimensions.instance.padding),
                    Text(
                      S.of(context).noPotentialObjectHasBeenDetected,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).disabledColor),
                    )
                  ],
                ),
              );
      },
    );
  }
}
