import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class GenerateItem extends StatelessWidget {
  const GenerateItem({super.key, required this.type});
  final QRType type;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIcon(
            type.icon,
            normal: true,
            size: AppDimensions.instance.iconX(2),
          ),
          SizedBox(height: AppDimensions.instance.paddingX(0.5)),
          Text(
            type.label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
