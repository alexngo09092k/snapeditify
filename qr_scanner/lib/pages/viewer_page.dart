import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_format.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage(this.qr, {super.key});
  final QR qr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BarcodeWidget(
          width: AwesomeAppState.screen.width * 2 / 3,
          height: qr.format == QRFormat.QrCode
              ? AwesomeAppState.screen.width * 2 / 3
              : AwesomeAppState.screen.width * 1 / 3,
          data: qr.rawData,
          barcode: qr.barcode,
        ),
      ),
    );
  }
}

extension BarcodeEX on QR {
  Barcode get barcode {
    switch (format) {
      case QRFormat.CodeUPCA:
        return Barcode.upcA();
      case QRFormat.CodeUPCE:
        return Barcode.upcE();
      case QRFormat.Code128:
        return Barcode.code128();
      case QRFormat.Code39:
        return Barcode.code39();
      case QRFormat.Code93:
        return Barcode.code93();
      case QRFormat.CodeEAN13:
        return Barcode.ean13();
      case QRFormat.CodeEAN2:
        return Barcode.ean2();
      case QRFormat.CodeEAN5:
        return Barcode.ean5();
      case QRFormat.CodeEAN8:
        return Barcode.ean8();
      case QRFormat.Codabar:
        return Barcode.codabar();
      case QRFormat.Aztec:
        return Barcode.aztec();
      case QRFormat.CodeITF14:
        return Barcode.itf14();
      case QRFormat.CodeITF16:
        return Barcode.itf16();
      case QRFormat.DataMatrix:
        return Barcode.dataMatrix();
      case QRFormat.Itf:
        return Barcode.itf();
      case QRFormat.PDF417:
        return Barcode.pdf417();
      case QRFormat.GS128:
        return Barcode.gs128();
      case QRFormat.Rm4scc:
        return Barcode.rm4scc();
      case QRFormat.Telepen:
        return Barcode.telepen();
      default:
        return Barcode.qrCode();
    }
  }
}
