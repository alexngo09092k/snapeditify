import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/providers/remover/remover_state.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class BrushModeSetting extends StatelessWidget {
  const BrushModeSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppDimensions.instance.padding),

        /// BRUSH BUTTON
        PropConsumer<IRemoverProvider, bool>(
          select: (p) => p.state.mode == RemoveObjectMode.brush,
          builder: (_, __, p, isBrush) => GestureDetector(
            onTap: () => p.toBrush(context),
            child: CustomIcon.defaultStyle(
              context,
              icon: AppAssets.instance.icHand,
              color: isBrush
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          ),
        ),

        /// STROKE WIDTH SLIDER
        Expanded(
          child: PropConsumer<RemoverProvider, double>(
            select: (p) => p.state.strokeWidth,
            builder: (_, __, p, strokeWidth) => Slider(
              min: 10,
              max: 100,
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
        PropConsumer<IRemoverProvider, bool>(
          select: (p) => p.state.mode == RemoveObjectMode.erase,
          builder: (_, __, p, isEraser) => GestureDetector(
            onTap: () => p.toErase(context),
            child: CustomIcon.defaultStyle(
              context,
              icon: AppAssets.instance.icEraser,
              color: isEraser
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.padding),
      ],
    );
  }
}
