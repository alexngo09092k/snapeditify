import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/models/qr.dart';

class ViewerPage extends StatelessWidget {
  const ViewerPage(this.qr, {super.key});
  final QR qr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: QrImageView(
          size: AwesomeAppState.screen.width * 2 / 3,
          data: qr.rawData,
        ),
      ),
    );
  }
}
