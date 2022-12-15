import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/pages/remove_object/widgets/detected_object_item.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';

class DetectedObjectList extends StatelessWidget {
  const DetectedObjectList({Key? key, required this.type, required this.provider}) : super(key: key);

  final DetectedObjectType type;
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return BasePropConsumer<RemoveObjectProvider, int>(
      listenable: provider,
      select: (p) => p.state.detectedObjects.values.where((detectedObject) => detectedObject.objectType == type).length,
      builder: (_, __, p, ___) {
        final data = p.state.detectedObjects.values.where((detectedObject) => detectedObject.objectType == type);
        return data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) => DetectedObjectItem(
                  key: Key('$index'),
                  detectedObject: data.elementAt(index),
                  provider: provider,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.instance.noObject,
                      width: AppDimensions.instance.iconX(2),
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
      },
    );
  }
}
