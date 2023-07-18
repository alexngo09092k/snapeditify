import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  String onData() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      qrType: QRType.email,
      onData: onData,
      child: const Column(
        children: [
          Input(hintText: "E-mail recipient"),
          Divider(),
          Input(hintText: "Subject"),
          Divider(),
          Input(hintText: "Body Text"),
        ],
      ),
    );
  }
}
