import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(this.icon, {super.key, this.size, this.color, this.background, this.spacing, this.radius});
  final String icon;
  final double? size;
  final Color? color;
  final Color? background;
  final double? spacing;
  final double? radius;

  factory CustomIcon.defaultStyle(
    BuildContext context, {
    required String icon,
    double? size,
    Color? color,
    Color? background,
    double? spacing,
  }) {
    return CustomIcon(
      icon,
      size: size ?? AppDimensions.instance.icon,
      color: color,
      spacing: spacing ?? AppDimensions.instance.iconX(0.5),
      background: background ?? Theme.of(context).disabledColor.withOpacity(0.1),
      radius: (size ?? AppDimensions.instance.icon) / 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size ?? AppDimensions.instance.icon,
        height: size ?? AppDimensions.instance.icon,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: size == null ? AppDimensions.instance.icon : (size ?? 0) - (spacing ?? 0),
            height: size == null ? AppDimensions.instance.icon : (size ?? 0) - (spacing ?? 0),
            color: color,
          ),
        ),
      ),
    );
  }
}
