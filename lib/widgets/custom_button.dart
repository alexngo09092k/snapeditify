import 'package:snapedit/common/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      this.gradient,
      this.textColor,
      this.titleSize = 14,
      this.color,
      this.width,
      this.height = 50,
      this.onTap,
      this.child,
      this.icon,
      this.title})
      : super(key: key);

  final Gradient? gradient;
  final String? title;
  final Color? textColor;
  final Color? color;
  final double? width;
  final double? height;
  final double? titleSize;
  final Widget? child;
  final Widget? icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? AppColors.topicColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          gradient: gradient,
        ),
        child: child ??
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon ?? const SizedBox(),
                  icon != null
                      ? const SizedBox(
                          width: AppDimensions.paddingSizeExtraSmall)
                      : const SizedBox(),
                  Text(
                    title ?? '',
                    style: TextStyle(
                      color: textColor ?? AppColors.kWhite,
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
