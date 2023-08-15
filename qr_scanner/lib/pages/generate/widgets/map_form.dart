import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_map_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
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

class _MapFormState extends BaseFormState<MapForm, QRMapForm> {
  @override
  void initState() {
    form = QRMapForm();
    super.initState();
  }

  void _onChanged(_MapField field, dynamic _) {
    switch (field) {
      case _MapField.latitude:
        form.latitude = double.tryParse(_) ?? 0.0;
        break;
      case _MapField.longitude:
        form.longitude = double.tryParse(_) ?? 0.0;
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.email,
      isDisabled: isDisabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gMaps),
            hintText: "Latitude",
            onChanged: (_) => _onChanged(_MapField.latitude, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gMaps),
            hintText: "Longitude",
            onChanged: (_) => _onChanged(_MapField.longitude, _),
          ),
        ],
      ),
    );
  }
}
