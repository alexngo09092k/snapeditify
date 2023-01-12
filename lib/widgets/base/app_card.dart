import 'package:flutter/material.dart';
import 'package:phosart/common/constants.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, this.color, this.child, this.width, this.height, this.padding});
  final Color? color;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
        color: Theme.of(context).cardColor,
        boxShadow: [AppColors.instance.boxShadow],
      ),
      child: child,
    );
  }
}
