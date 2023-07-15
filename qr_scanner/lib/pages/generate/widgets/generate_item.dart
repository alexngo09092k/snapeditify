import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class GenerateItem extends StatelessWidget {
  const GenerateItem({super.key, required this.type, required this.onQRType});
  final QRType type;
  final Function(QRType) onQRType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onQRType(type),
      child: AppCard(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIcon(
              type.icon,
              size: AppDimensions.instance.iconX(2),
              color: Colors.lightBlue,
            ),
            SizedBox(height: AppDimensions.instance.paddingX(0.5)),
            Text(
              type.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
