import 'package:flutter/material.dart';
import 'package:qr_scanner/common/app_routes.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.qr});
  final QR qr;

  _onView(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.viewerPage, arguments: qr);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onView(context),
      child: AppCard(
        margin: EdgeInsets.only(bottom: AppDimensions.instance.padding).copyWith(
          left: AppDimensions.instance.padding,
          right: AppDimensions.instance.padding,
        ),
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: Row(
          children: [
            CustomIcon(
              qr.type.icon, 
              normal: true, 
              size: AppDimensions.instance.iconX(1.5), 
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: AppDimensions.instance.padding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(qr.rawData, style: Theme.of(context).textTheme.bodyLarge,),
                  Text(qr.type.label, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
