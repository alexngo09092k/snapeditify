import 'package:flutter/material.dart';
import 'package:qr_scanner/models/qr_forms/qr_map_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _MapField {
  latitude,
  longitude,
}

class MapForm extends StatefulWidget {
  const MapForm({super.key});

  @override
  State<MapForm> createState() => _MapFormState();
}

class _MapFormState extends State<MapForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRMapForm _form = QRMapForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_MapField field, dynamic _) {
    switch (field) {
      case _MapField.latitude:
        _form.latitude = double.tryParse(_) ?? 0.0;
        break;
      case _MapField.longitude:
        _form.longitude = double.tryParse(_) ?? 0.0;
        break;
    }

    _isDisabled.value = !_form.validate();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.email,
      isDisabled: _isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            hintText: "Latitude",
            onChanged: (_) => _onChanged(_MapField.latitude, _),
          ),
          Input(
            hintText: "Longitude",
            onChanged: (_) => _onChanged(_MapField.longitude, _),
          ),
        ],
      ),
    );
  }
}
