import 'package:flutter/material.dart';
import 'package:qr_scanner/common/app_routes.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_format.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:qr_scanner/widgets/base/custom_button.dart';

class BaseForm extends StatefulWidget {
  const BaseForm({
    super.key,
    required this.qrType,
    required this.child,
    required this.onData,
    this.isDisabled,
  });

  final QRType qrType;
  final Widget child;
  final String? Function() onData;
  final ValueNotifier<bool>? isDisabled;

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  final ValueNotifier<QRFormat> barcodeType = ValueNotifier(QRFormat.QrCode);

  void onGenerate() {
    final String? data = widget.onData();
    if (data == null) return;

    final QR qr = QR(
      rawData: data,
      type: widget.qrType,
      source: QRSource.isGenerated,
      lastModified: DateTime.now(),
    );

    HistoryProvider.instance.addQR(qr);

    Navigator.of(context).pushNamed(AppRoutes.viewerPage, arguments: qr);
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CustomIcon(
                //   qrType.icon,
                //   color: Theme.of(context).colorScheme.primary,
                // ),
                // SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                Text(
                  "Generate QR for ${widget.qrType.label}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: AppDimensions.instance.padding),
            widget.child,
              AnimatedBuilder(
                animation: barcodeType,
                builder: (_, __) => Column(
                  children: [
                    SizedBox(height: AppDimensions.instance.padding),

                    /// Toogle Barcode
                    /// Barcode Type
                  ],
                ),
              ),
            SizedBox(height: AppDimensions.instance.padding),
            widget.isDisabled != null
                ? AnimatedBuilder(
                    animation: widget.isDisabled!,
                    builder: (_, __) => CustomButton(
                      title: "Generate",
                      onTap: onGenerate,
                      height: 50,
                      isDisabled: widget.isDisabled!.value,
                    ),
                  )
                : CustomButton(
                    title: "Generate",
                    onTap: onGenerate,
                    height: 50,
                  ),
          ],
        ),
      ),
    );
  }
}
