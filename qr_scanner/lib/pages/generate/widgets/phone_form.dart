import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_forms/qr_phone_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({super.key});

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends BaseFormState<PhoneForm, QRPhoneForm> {
  @override
  void initState() {
    form = QRPhoneForm();
    super.initState();
  }

  void _onChanged(String _) {
    form.phone = _;
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.tel,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            // prefixIcon: PrefixIcon(icon: AppAssets.instance.g),
            hintText: "Your phone number",
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
