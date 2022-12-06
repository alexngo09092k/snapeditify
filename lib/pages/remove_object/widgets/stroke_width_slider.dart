import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/remove_object_provider/remove_object_provider.dart';

class StrokeWidthSlider extends StatelessWidget {
  const StrokeWidthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PropConsumer<RemoveObjectProvider, bool>(
          select: (p) => p.isDraw,
          builder: (_, __, p, ___) => IconButton(
            onPressed: p.toDraw,
            icon: Image.asset(
              p.isDraw ? AppAssets.instance.icFingerbrushSelectedNormal3x : AppAssets.instance.icFingerbrushUnselectedNormal3x,
              width: 40,
            ),
          ),
        ),
        Expanded(
          child: PropConsumer<RemoveObjectProvider, double>(
            select: (p) => p.strokeWidth,
            builder: (_, __, p, ___) => Slider(
              min: 1,
              max: 100,
              value: p.strokeWidth,
              label: '${p.strokeWidth.round()}',
              divisions: 100,
              onChanged: (value) => p.state.strokeWidth = value,
              onChangeStart: (_) => p.state.changedStrokeWidth = true,
              onChangeEnd: (_) => p.state.changedStrokeWidth = false,
            ),
          ),
        ),
        PropConsumer<RemoveObjectProvider, bool>(
          select: (p) => p.isErase,
          builder: (_, __, p, ___) => IconButton(
            onPressed: p.toErase,
            icon: Image.asset(
              p.isErase ? AppAssets.instance.icEraserSelectedNormal3x : AppAssets.instance.icEraserUnselectedNormal3x,
              width: 40,
            ),
          ),
        ),
      ],
    );
  }
}
