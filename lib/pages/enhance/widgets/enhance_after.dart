import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/widgets/painter/painter_pure.dart';

class EnhanceAfter extends StatelessWidget {
  const EnhanceAfter({Key? key, required this.provider}) : super(key: key);
  final EnhanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: provider.state.image.ratio,
        child: Stack(
          children: [
            BasePropConsumer<EnhanceProvider, PainterController>(
              listenable: provider,
              select: (p) => p.state.paintAfter,
              builder: (_, __, ___, paint) => FlutterPainter(controller: paint),
            ),
            Positioned(
              right: AppDimensions.instance.padding,
              top: AppDimensions.instance.padding,
              child: Text(
                S.of(context).after,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
