import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.constraints,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(
                AppDimensions.instance.radiusLarge,
              ),
            ),
        color: Theme.of(context).cardColor,
      ),
      child: child,
    );
  }
}
