import 'package:flutter/material.dart';
import 'package:snapedit/models/enhance_handler.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';

class EnhanceFaceItem extends StatelessWidget {
  const EnhanceFaceItem({super.key, required this.provider, required this.face});
  final EnhanceProvider provider;
  final FaceHandler face;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // final imageWidget = ClipRRect(
    //   borderRadius: const BorderRadius.all(Radius.circular(5)),
    //   child: SizedBox(
    //     width: 60,
    //     height: 60,
    //     child: Center(
    //       child: face.image != null ? Image.network(face.png.first) : const SizedBox(),
    //     ),
    //   ),
    // );
    // final actionWidget = BasePropConsumer<RemoveObjectProvider, bool>(
    //   listenable: provider,
    //   select: (p) => p.state.detectedObjects[detectedObject.maskId]!.isSelected,
    //   builder: (_, __, p, ___) {
    //     return Container(
    //       alignment: Alignment.center,
    //       child: Image.asset(
    //         detectedObject.isSelected ? AppAssets.instance.icCheckboxSelected : AppAssets.instance.icCheckbox,
    //         width: 30,
    //       ),
    //     );
    //   },
    // );
    // final subTitle = Text(
    //   '${(double.parse(detectedObject.accuracy) * 100).toStringAsFixed(2)} ${S.of(context).accurate}',
    //   style: Theme.of(context).textTheme.bodyText2!,
    // );
    // final title = Text(
    //   detectedObject.objectDescription,
    //   style: Theme.of(context).textTheme.subtitle1,
    // );

    // return BasePropConsumer<RemoveObjectProvider, bool>(
    //   listenable: provider,
    //   select: (p) => p.state.detectedObjects[detectedObject.maskId]?.isRemoved ?? false,
    //   builder: (_, __, p, ___) => TileRow(
    //     leading: imageWidget,
    //     main: Column(
    //       children: [
    //         Row(children: [title, if (p.state.detectedObjects[detectedObject.maskId]?.isRemoved ?? false) removeText]),
    //         subTitle
    //       ],
    //     ),
    //     action: actionWidget,
    //   ),
    // );
  }
}
