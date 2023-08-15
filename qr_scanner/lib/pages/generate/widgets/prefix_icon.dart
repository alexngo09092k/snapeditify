import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class PrefixIcon extends StatelessWidget {
  const PrefixIcon({super.key, required this.icon, this.normal = false});
  final String icon;
  final bool normal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.instance.iconX(1.5),
      child: Center(
        child: CustomIcon(
          icon,
          color: Theme.of(context).primaryColor,
          normal: normal,
        ),
      ),
    );
  }
}
