import 'package:phosart/common/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.gradient,
      this.titleColor,
      this.titleSize = 14,
      this.color,
      this.width,
      this.height,
      this.onTap,
      this.child,
      this.icon,
      this.title})
      : super(key: key);

  final Gradient? gradient;
  final String? title;
  final Color? titleColor;
  final Color? color;
  final double? width;
  final double? height;
  final double? titleSize;
  final Widget? child;
  final Widget? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.instance.padding,
          vertical: AppDimensions.instance.paddingX(0.5),
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.instance.mediumSlateBlue,
          borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(3))),
          gradient: gradient,
          boxShadow: [AppColors.instance.boxShadow],
        ),
        child: child ??
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon ?? const SizedBox(),
                  icon != null ? SizedBox(width: AppDimensions.instance.paddingX(0.5)) : const SizedBox(),
                  Text(
                    title ?? '',
                    style: TextStyle(
                      color: titleColor ?? AppColors.instance.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
      ),
    );
  }
}
