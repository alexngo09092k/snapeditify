import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/widgets/custom_button.dart';

class CustomDialogButton {
  String title;
  Color? color;
  LinearGradient? gradient;
  Color? titleColor;
  void Function()? action;

  CustomDialogButton(
      {required this.title,
      this.color,
      this.action,
      this.titleColor,
      this.gradient});
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.title,
    this.message,
    this.buttons,
    this.width = 300,
    this.height,
  }) : super(key: key);

  final Widget? title;
  final Widget? message;
  final List<CustomDialogButton>? buttons;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).backgroundColor,
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.instance.paddingSizeDefault),
        ),
      ),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.instance.paddingSizeDefault,
            vertical: AppDimensions.instance.paddingSizeExtraLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) title!,
                if (title != null)
                 SizedBox(height: AppDimensions.instance.paddingSizeDefault),
                if (message != null) message!,
              ],
            ),
            if (buttons != null)
              Padding(
                padding: EdgeInsets.only(
                    top: AppDimensions.instance.paddingSizeDefault),
                child: buttons!.length == 1
                    ? Expanded(
                        child: CustomButton(
                        title: buttons!.first.title,
                        onTap: buttons!.first.action,
                        color: buttons!.first.color,
                        gradient: buttons!.first.gradient,
                        titleColor: buttons!.first.titleColor,
                        height: 40,
                      ))
                    : Row(
                        children: buttons!
                            .asMap()
                            .keys
                            .map((index) => Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: index == buttons!.length - 1
                                            ? 0
                                            : 10),
                                    child: CustomButton(
                                      title: buttons![index].title,
                                      onTap: buttons![index].action,
                                      color: buttons![index].color,
                                      gradient: buttons![index].gradient,
                                      titleColor: buttons![index].titleColor,
                                      height: 40,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
              )
          ],
        ),
      ),
    );
  }
}
