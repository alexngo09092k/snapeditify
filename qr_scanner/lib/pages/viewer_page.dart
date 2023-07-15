import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_data.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage(this.qrData, {super.key});
  final QRData qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
