import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.color,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.constraints,
  });
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
        color: color ?? Theme.of(context).colorScheme.surface,
        boxShadow: [AppColors.instance.boxShadow],
      ),
      child: child,
    );
  }
}
