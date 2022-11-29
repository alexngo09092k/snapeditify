import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/edit_provider/edit_provider.dart';

class StrokeWidthSlider extends StatelessWidget {
  const StrokeWidthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PropConsumer<EditProvider, bool>(
          select: (p) => p.isDraw,
          builder: (_, __, p, ___) => IconButton(
            onPressed: p.toDraw,
            icon: Image.asset(
              p.isDraw ? AppImages.instance.icFingerbrushSelectedNormal3x : AppImages.instance.icFingerbrushUnselectedNormal3x,
              width: 40,
            ),
          ),
        ),
        Expanded(
          child: PropConsumer<EditProvider, double>(
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
        PropConsumer<EditProvider, bool>(
          select: (p) => p.isErase,
          builder: (_, __, p, ___) => IconButton(
            onPressed: p.toErase,
            icon: Image.asset(
              p.isErase ? AppImages.instance.icEraserSelectedNormal3x : AppImages.instance.icEraserUnselectedNormal3x,
              width: 40,
            ),
          ),
        ),
      ],
    );
  }
}
