import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';

class EnhanceAfter extends StatelessWidget {
  const EnhanceAfter({Key? key, required this.provider}) : super(key: key);
  final EnhanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: (provider.imageUI.width / provider.imageUI.height),
        child: BasePropConsumer<EnhanceProvider, PainterController>(
          listenable: provider,
          select: (p) => p.state.paintAfter,
          builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paintAfter),
        ),
      ),
    );
  }
}
