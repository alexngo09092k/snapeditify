import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';

class StrokeWidthSlider extends StatelessWidget {
  const StrokeWidthSlider({Key? key, required this.controller})
      : super(key: key);

  final EditController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: controller.toDraw,
          icon: Image.asset(
            controller.isDraw
                ? AppImages.icFingerbrushSelectedNormal3x
                : AppImages.icFingerbrushUnselectedNormal3x,
            width: 40,
          ),
        ),
        Expanded(
          child: Slider(
            min: 1,
            max: 100,
            value: controller.strokeWidth,
            label: '${controller.strokeWidth.round()}',
            divisions: 100,
            onChanged: (value)=> controller.state.strokeWidth = value,
          ),
        ),
        IconButton(
          onPressed: controller.toErase,
          icon: Image.asset(
            controller.isErase
                ? AppImages.icEraserSelectedNormal3x
                : AppImages.icEraserUnselectedNormal3x,
            width: 40,
          ),
        ),
      ],
    );
  }
}
