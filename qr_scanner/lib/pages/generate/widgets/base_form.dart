import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/widgets/base/custom_button.dart';

class BaseForm extends StatelessWidget {
  const BaseForm({
    super.key,
    required this.qrType,
    required this.child,
    required this.onGenerate,
  });

  final QRType qrType;
  final Widget child;
  final Function() onGenerate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(AppDimensions.instance.padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.instance.radius),
        ),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Generate QR for ${qrType.label}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimensions.instance.padding),
            child,
            SizedBox(height: AppDimensions.instance.padding),
            CustomButton(
              title: "Generate",
              onTap: onGenerate,
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
