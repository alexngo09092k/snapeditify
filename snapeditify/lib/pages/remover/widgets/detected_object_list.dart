import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/remover/widgets/detected_object_item.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/services/snap_edit/snap_edit.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class DetectedObjectList extends StatelessWidget {
  const DetectedObjectList({Key? key, required this.type, required this.provider}) : super(key: key);

  final DetectedObjectType type;
  final RemoverProvider provider;

  @override
  Widget build(BuildContext context) {
    return PropConsumer<IRemoverProvider, int>(
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
                    LottieViewer(
                      lottie: AppAssets.instance.notFound,
                      width: AppDimensions.instance.iconX(3),
                      height: AppDimensions.instance.iconX(3),
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
