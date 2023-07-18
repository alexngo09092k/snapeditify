import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class WifiForm extends StatelessWidget {
  const WifiForm({super.key});

  String onData() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.wifi,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(hintText: "Wifi SSID (Name)"),
          Divider(),
          Input(hintText: "Password"),
        ],
      ),
    );
  }
}
