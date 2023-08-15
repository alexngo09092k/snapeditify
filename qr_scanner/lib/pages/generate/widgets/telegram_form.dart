import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_telegram_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _TelegramField {
  username,
}

class TelegramForm extends StatefulWidget {
  const TelegramForm({super.key});

  @override
  State<TelegramForm> createState() => _TelegramFormState();
}

class _TelegramFormState extends BaseFormState<TelegramForm, QRTelegramForm> {
  @override
  void initState() {
    form = QRTelegramForm();
    super.initState();
  }

  void _onChanged(_TelegramField field, dynamic _) {
    switch (field) {
      case _TelegramField.username:
        form.username = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.telegram,
      isDisabled: isDisabled,
      child: Input(
        prefixIcon: PrefixIcon(icon: AppAssets.instance.gTelegram),
        hintText: "@username",
        onChanged: (_) => _onChanged(_TelegramField.username, _),
      ),
    );
  }
}
