import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      this.color,
      required this.child,
      this.margin,
      this.radius = 0,
      this.gradient,
      this.padding})
      : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Color? color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            //  color: AppColors.kGrey.withOpacity(0.2),
            // spreadRadius: 5,
            // blurRadius: 7,
            // offset: const Offset(0, 3),
            color: AppColors.kGrey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 15.0,
            offset: const Offset(0.0, 4)
          )
        ],
      ),
      child: child,
    );
  }
}
