import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_forms/qr_sms_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _SMSField {
  phoneNumber,
  message,
}

class SMSForm extends StatefulWidget {
  const SMSForm({super.key});

  @override
  State<SMSForm> createState() => _SMSFormState();
}

class _SMSFormState extends State<SMSForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRSMSForm _form = QRSMSForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_SMSField field, String _) {
    switch (field) {
      case _SMSField.phoneNumber:
        _form.phoneNumber = _;
        break;
      case _SMSField.message:
        _form.message = _;
        break;
    }

    _isDisabled.value = !_form.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.link,
      isDisabled: _isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            hintText: "Your phone number",
            onChanged:(_) => _onChanged(_SMSField.phoneNumber, _),
          ),
          Input(
            hintText: "Your message",
            onChanged:(_) => _onChanged(_SMSField.message, _),
          ),
        ],
      ),
    );
  }
}
