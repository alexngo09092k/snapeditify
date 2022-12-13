import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/providers/remove_object/remove_object_state.dart';

class BrushModeSetting extends StatelessWidget {
  const BrushModeSetting({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  _showColorPopup(BuildContext context) {
    provider.changeStrokeColor(context, Colors.black.withOpacity(0.5));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// BRUSH BUTTON
        GestureDetector(
          onTap: () => provider.toBrush(context),
          child: BasePropConsumer<RemoveObjectProvider, bool>(
            listenable: provider,
            select: (p) => p.state.mode == RemoveObjectMode.brush,
            builder: (_, __, p, ___) => Image.asset(
              AppAssets.instance.icAdd,
              color: p.state.mode == RemoveObjectMode.brush ? AppColors.instance.blue : AppColors.instance.black,
              width: AppDimensions.instance.icon,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.paddingX(1)),

        /// COLOR BUTTON
        GestureDetector(
          onTap: () => _showColorPopup(context),
          child: BasePropConsumer<RemoveObjectProvider, Color>(
            listenable: provider,
            select: (p) => p.state.strokeColor,
            builder: (_, __, p, ___) => Container(
              width: AppDimensions.instance.icon,
              height: AppDimensions.instance.icon,
              decoration: BoxDecoration(
                color: p.state.strokeColor,
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
              ),
              child: Image.asset(
                AppAssets.instance.icAdd,
                color: p.state.mode == RemoveObjectMode.brush ? AppColors.instance.blue : AppColors.instance.black,
                width: AppDimensions.instance.icon,
              ),
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.paddingX(1)),

        /// STROKE WIDTH SLIDER
        Expanded(
          child: BasePropConsumer<RemoveObjectProvider, double>(
            listenable: provider,
            select: (p) => p.state.strokeWidth,
            builder: (_, __, p, ___) => Slider(
              min: 1,
              max: 100,
              value: p.state.strokeWidth,
              label: '${p.state.strokeWidth.round()}',
              divisions: 100,
              onChanged: (value) => p.state.strokeWidth = value,
              onChangeStart: (_) => p.strokeWidthIsChanged = true,
              onChangeEnd: (_) => p.strokeWidthIsChanged = false,
            ),
          ),
        ),
        SizedBox(width: AppDimensions.instance.paddingX(1)),

        /// ERASE BUTTON
        GestureDetector(
          onTap: () => provider.toErase(context),
          child: BasePropConsumer<RemoveObjectProvider, bool>(
            listenable: provider,
            select: (p) => p.state.mode == RemoveObjectMode.erase,
            builder: (_, __, p, ___) => Image.asset(
              AppAssets.instance.icAdd,
              color: p.state.mode == RemoveObjectMode.erase ? AppColors.instance.blue : AppColors.instance.black,
              width: AppDimensions.instance.icon,
            ),
          ),
        ),
      ],
    );
  }
}
