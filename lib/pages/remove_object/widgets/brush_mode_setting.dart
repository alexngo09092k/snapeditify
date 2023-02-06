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
            builder: (_, __, ___, isBrush) => CustomIcon.defaultStyle(
              context,
              icon: AppAssets.instance.icHand,
              color: isBrush ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
            ),
          ),
        ),

        /// STROKE WIDTH SLIDER
        Expanded(
          child: BasePropConsumer<RemoveObjectProvider, double>(
            listenable: provider,
            select: (p) => p.state.strokeWidth,
            builder: (_, __, p, strokeWidth) => Slider(
              min: p.config.removeObject.strokeWidth.min.toDouble(),
              max: p.config.removeObject.strokeWidth.max.toDouble(),
              value: strokeWidth,
              label: '${strokeWidth.round()}',
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
            builder: (_, __, ___, isEraser) => CustomIcon.defaultStyle(
              context,
              icon: AppAssets.instance.icEraser,
              color:isEraser ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.padding),
      ],
    );
  }
}
