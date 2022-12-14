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
      color: color ?? Theme.of(context).iconTheme.color,
      spacing: spacing ?? AppDimensions.instance.iconX(0.5),
      background: background ?? Theme.of(context).disabledColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(spacing ?? 0),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: size == null ? null : (size ?? 0) - (spacing ?? 0),
            height: size == null ? null : (size ?? 0) - (spacing ?? 0),
          ),
        ),
      ),
    );
  }
}
