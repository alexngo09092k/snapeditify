import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/utils/qr.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

class URLForm extends StatefulWidget {
  const URLForm({super.key});

  @override
  State<URLForm> createState() => _URLFormState();
}

class _URLFormState extends State<URLForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(false);
  final ValueNotifier<String?> _qr = ValueNotifier(null);

  String? onData() => _qr.value!;

  void _onChanged(String _) {
    _qr.value = QRUtils.instance.buildRawData(QRType.link, _);
    _isDisabled.value = _qr.value == null || _qr.value!.isEmpty;
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
            hintText: "http or https://",
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
