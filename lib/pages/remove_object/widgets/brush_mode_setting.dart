import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_state.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class BrushModeSetting extends StatelessWidget {
  const BrushModeSetting({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppDimensions.instance.padding),

        /// BRUSH BUTTON
        GestureDetector(
          onTap: () => provider.toBrush(context),
          child: BasePropConsumer<RemoveObjectProvider, bool>(
            listenable: provider,
            select: (p) => p.state.mode == RemoveObjectMode.brush,
            builder: (_, __, p, ___) => CustomIcon.defaultStyle(
              context,
              icon: AppAssets.instance.icHand,
              color: p.state.mode == RemoveObjectMode.brush ? Theme.of(context).primaryColor : null,
            ),
          ),
        ),

        /// STROKE WIDTH SLIDER
        Expanded(
          child: BasePropConsumer<RemoveObjectProvider, double>(
            listenable: provider,
            select: (p) => p.state.strokeWidth,
            builder: (_, __, p, ___) => Slider(
              min: p.config.removeObject.strokeWidth.min.toDouble(),
              max: p.config.removeObject.strokeWidth.max.toDouble(),
              value: p.state.strokeWidth,
              label: '${p.state.strokeWidth.round()}',
              divisions: 100,
              onChanged: (value) => p.changeStrokeWidth(context, value),
              onChangeStart: (_) => p.strokeWidthIsChanged = true,
              onChangeEnd: (_) => p.strokeWidthIsChanged = false,
            ),
          ),
        ),

        /// ERASE BUTTON
        GestureDetector(
          onTap: () => provider.toErase(context),
          child: BasePropConsumer<RemoveObjectProvider, bool>(
            listenable: provider,
            select: (p) => p.state.mode == RemoveObjectMode.erase,
            builder: (_, __, p, ___) => CustomIcon.defaultStyle(
              context,
              icon: AppAssets.instance.icEraser,
              color: p.state.mode == RemoveObjectMode.erase ? Theme.of(context).primaryColor : null,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.padding),
      ],
    );
  }
}
