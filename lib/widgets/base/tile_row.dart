import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class TileRow extends StatelessWidget {
  const TileRow({super.key, this.leading, required this.main, this.action, this.onTap, this.padding});

  final Widget? leading;
  final Widget main;
  final Widget? action;
  final EdgeInsetsGeometry? padding;
  final void Function(BuildContext)? onTap;

  factory TileRow.defaultStyle(
    BuildContext context, {
    required String title,
    String? image,
    void Function(BuildContext)? onTap,
    bool normal = false,
  }) {
    return TileRow(
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      onTap: onTap,
      main: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: image != null
          ? Padding(
              padding: EdgeInsets.only(right: AppDimensions.instance.padding),
              child: CustomIcon(
                image,
                normal: normal,
              ),
            )
          : null,
      action: const CustomIcon(CupertinoIcons.forward),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(context) : null,
      child: Container(
        color: Colors.transparent,
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ?? const SizedBox(),
                main,
              ],
            ),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
