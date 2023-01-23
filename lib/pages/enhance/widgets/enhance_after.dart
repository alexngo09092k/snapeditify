import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/enhance/enhance_provider.dart';
import 'package:phosart/widgets/painter/painter_pure.dart';

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
              builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paintAfter),
            ),
            Positioned(
              right: AppDimensions.instance.padding,
              top: AppDimensions.instance.padding,
              child: Text(
                'After',
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
