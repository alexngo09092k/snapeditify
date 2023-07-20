import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_format.dart';
import 'package:qr_scanner/widgets/app_use/app_layout.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage(this.qr, {super.key});
  final QR qr;

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BarcodeWidget(
          width: AwesomeAppState.screen.width * 2 / 3,
          height: qr.format == QRFormat.QrCode
              ? AwesomeAppState.screen.width * 2 / 3
              : AwesomeAppState.screen.width * 1 / 3,
          data: qr.rawData,
          barcode: qr.format.barcode,
        ),
      ],
    );
  }
}
