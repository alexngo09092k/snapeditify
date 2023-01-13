import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/providers/enhance/enhance_provider.dart';
import 'package:phosart/widgets/painter/painter_pure.dart';

class EnhanceBefore extends StatelessWidget {
  const EnhanceBefore({Key? key, required this.provider}) : super(key: key);
  final EnhanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: provider.state.image.ratio,
        child: BasePropConsumer<EnhanceProvider, PainterController>(
          listenable: provider,
          select: (p) => p.state.paintBefore,
          builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paintBefore),
        ),
      ),
    );
  }
}
