import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/app_use/image_editor/modules/colors_picker.dart';

class ImageColorFilter extends StatefulWidget {
  const ImageColorFilter({
    super.key,
    required this.color,
    required this.opacity,
    required this.radius,
    required this.onChangeColor,
    required this.onResetColor,
    required this.onChangeRadius,
    required this.onResetRadius,
    required this.onChangeOpacity,
    required this.onResetOpacity,
  });
  final Color color;
  final double radius;
  final double opacity;

  final Function(Color) onChangeColor;
  final Function() onResetColor;
  final Function(double) onChangeRadius;
  final Function() onResetRadius;
  final Function(double) onChangeOpacity;
  final Function() onResetOpacity;

  @override
  State<ImageColorFilter> createState() => _ImageColorFilterState();
}

class _ImageColorFilterState extends State<ImageColorFilter> {
  late double radius;
  late double opacity;
  late Color color;

  @override
  void initState() {
    setState(() {
      radius = widget.radius;
      opacity = widget.opacity;
      color = widget.color;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppDimensions.instance.radius),
            topLeft: Radius.circular(AppDimensions.instance.radius),
          ),
        ),
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        height: 250,
        child: Column(
          children: [
            Center(
              child: Text(
                'Slider Filter Color'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(height: AppDimensions.instance.paddingX(2)),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'Color',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5)),
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        return BarColorPicker(
                          width: constraints.maxWidth - AppDimensions.instance.paddingX(2),
                          thumbColor: AppColors.instance.white,
                          cornerRadius: AppDimensions.instance.radius,
                          pickMode: PickMode.color,
                          initialColor: color,
                          colorListener: (int value) {
                            color = Color(value);
                            widget.onChangeColor(Color(value));
                          },
                        );
                      }
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onResetColor();
                    color = Colors.transparent;
                  },
                  child: Text(
                    'Reset',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'Radius',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Slider(
                    value: radius,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (_) {
                      setState(() {
                        radius =  _;
                        widget.onChangeRadius(_);
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      radius = 0;
                      widget.onResetRadius();
                    });
                  },
                  child: Text(
                    'Reset',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'Opacity',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: opacity,
                    min: 0.00,
                    max: 1.0,
                    onChanged: (_) {
                      setState(() {
                        opacity = _;
                        widget.onChangeOpacity(_);
                      });
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      opacity = 0.0;
                      widget.onResetOpacity();
                    });
                  },
                  child: Text(
                    'Reset',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
