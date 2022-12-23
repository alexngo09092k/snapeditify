import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';

class EnhanceBefore extends StatelessWidget {
  const EnhanceBefore({Key? key, required this.provider}) : super(key: key);
  final EnhanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: (provider.state.imageUI.width / provider.state.imageUI.height),
        child: BasePropConsumer<EnhanceProvider, PainterController>(
          listenable: provider,
          select: (p) => p.state.paintBefore,
          builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paintBefore),
        ),
      ),
    );
  }
}
