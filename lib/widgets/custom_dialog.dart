import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/custom_button.dart';

class CustomDialogButton {
  String title;
  Color? color;
  Color? titleColor;
  void Function()? action;

  CustomDialogButton({
    required this.title,
    this.color,
    this.action,
    this.titleColor
  });
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
      insetPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/3),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSizeDefault,
          vertical: AppDimensions.paddingSizeExtraLarge
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) title!,
                if (title != null)
                  const SizedBox(height: AppDimensions.paddingSizeDefault),
                if (message != null) message!,
              ],
            ),
            if (buttons != null)
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.paddingSizeDefault),
                child: buttons!.length == 1
                    ? Expanded(
                        child: CustomButton(
                        title: buttons!.first.title,
                        onTap: buttons!.first.action,
                        color: buttons!.first.color,
                        textColor: buttons!.first.titleColor,
                        height: 30,
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
                                      textColor: buttons![index].titleColor,
                                      height: 35,
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
