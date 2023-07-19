import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_forms/qr_phone_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({super.key});

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRPhoneForm _form = QRPhoneForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(String _) {
    _form.phone = _;

    _isDisabled.value = !_form.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.tel,
      isDisabled: _isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            hintText: "Your phone number",
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
