import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_data.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.qrData});
  final QRData qrData;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.only(bottom: AppDimensions.instance.padding).copyWith(
        left: AppDimensions.instance.padding,
        right: AppDimensions.instance.padding,
      ),
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Row(
        children: [
          CustomIcon(qrData.qrType.icon, normal: true, size: 40,),
          SizedBox(width: AppDimensions.instance.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(qrData.qrData, style: Theme.of(context).textTheme.bodyLarge),
              Text(qrData.qrType.label, style: Theme.of(context).textTheme.bodyMedium),
            ],
          )
        ],
      ),
    );
  }
}
