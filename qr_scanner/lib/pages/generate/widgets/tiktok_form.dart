import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_tiktok_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _TikTokField {
  username,
}

class TikTokForm extends StatefulWidget {
  const TikTokForm({super.key});

  @override
  State<TikTokForm> createState() => _TikTokFormState();
}

class _TikTokFormState extends BaseFormState<TikTokForm, QRTikTokForm> {
  @override
  void initState() {
    form = QRTikTokForm();
    super.initState();
  }

  void _onChanged(_TikTokField field, dynamic _) {
    switch (field) {
      case _TikTokField.username:
        form.username = _;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.tiktok,
      isDisabled: isDisabled,
      child: Input(
        prefixIcon: PrefixIcon(icon: AppAssets.instance.gTiktok),
        hintText: "@username",
        onChanged: (_) => _onChanged(_TikTokField.username, _),
      ),
    );
  }
}
