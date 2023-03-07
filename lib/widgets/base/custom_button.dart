import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.gradient,
    this.titleColor,
    this.titleSize = 14,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.child,
    this.icon,
    this.title,
    this.isLoading = false,
  }) : super(key: key);

  final Gradient? gradient;
  final String? title;
  final Color? titleColor;
  final Color? color;
  final double? width;
  final double? height;
  final double? titleSize;
  final Widget? child;
  final Widget? icon;
  final bool isLoading;
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
          color: color ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radiusX(3))),
          gradient: gradient,
          boxShadow: [AppColors.instance.boxShadow],
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: titleColor ?? Theme.of(context).colorScheme.onPrimary)
            : child ??
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon ?? const SizedBox(),
                      icon != null? SizedBox(width: AppDimensions.instance.paddingX(0.5)): const SizedBox(),
                      if (title != null)
                        Text(
                          title!,
                          style: TextStyle(
                            color: titleColor ?? Theme.of(context).colorScheme.onPrimary,
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
