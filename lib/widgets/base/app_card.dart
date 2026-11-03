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
    this.borderRadius,
    this.border,
  });
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = borderRadius ??
        BorderRadius.all(Radius.circular(AppDimensions.instance.radius));
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: color ?? Theme.of(context).colorScheme.surface,
        boxShadow: [AppColors.instance.softShadow],
        border: border ??
            Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFE8EAF0),
              width: 1,
            ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
