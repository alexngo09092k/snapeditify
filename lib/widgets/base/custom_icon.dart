// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(this.icon, {super.key, this.size, this.color, this.background, this.spacing, this.radius, this.normal = false});
  final dynamic icon;
  final double? size;
  final Color? color;
  final Color? background;
  final double? spacing;
  final double? radius;
  final bool normal;

  factory CustomIcon.defaultStyle(
    BuildContext context, {
    required dynamic icon,
    double? size,
    Color? color,
    Color? background,
    double? spacing,
    bool normal = false,
  }) {
    return CustomIcon(
      icon,
      size: size ?? AppDimensions.instance.iconX(1.2),
      color: color,
      spacing: spacing ?? AppDimensions.instance.iconX(0.5),
      background: background ?? Theme.of(context).iconTheme.color!.withOpacity(0.1),
      radius: (size ?? AppDimensions.instance.iconX(1.2)) / 2,
      normal: normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = size == null ? AppDimensions.instance.icon : (size ?? 0) - (spacing ?? 0);
    final _color = !normal ? (color ?? Theme.of(context).iconTheme.color) : null;
    return Center(
      child: Container(
        width: size ?? AppDimensions.instance.icon,
        height: size ?? AppDimensions.instance.icon,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        ),
        child: Center(
          child: icon is IconData
              ? Transform.translate(
                  offset: const Offset(0, 0),

                  /// Fix spacing
                  child: Icon(
                    icon,
                    size: _size,
                    color: _color,
                  ),
                )
              : (icon is String
                  ? CustomImage(
                      image: icon,
                      width: _size,
                      height: _size,
                      color: _color,
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
