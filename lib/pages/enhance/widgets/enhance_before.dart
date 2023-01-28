import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/enhance/enhance_provider.dart';
import 'package:snapeditify/widgets/painter/painter_pure.dart';

class EnhanceBefore extends StatelessWidget {
  const EnhanceBefore({Key? key, required this.provider}) : super(key: key);
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
              select: (p) => p.state.paintBefore,
              builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paintBefore),
            ),
            Positioned(
              left: AppDimensions.instance.padding,
              top: AppDimensions.instance.padding,
              child: Text(
                S.of(context).before,
                style: Theme.of(context).textTheme.headline5!.copyWith(
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
