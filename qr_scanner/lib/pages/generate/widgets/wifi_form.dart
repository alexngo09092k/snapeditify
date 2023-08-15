import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_wifi_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/pefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _WifiField {
  ssid,
  password,
  hidden,
  encryption,
}

class WifiForm extends StatefulWidget {
  const WifiForm({super.key});

  @override
  State<WifiForm> createState() => _WifiFormState();
}

class _WifiFormState extends BaseFormState<WifiForm, QRWifiForm> {
  @override
  void initState() {
    form = QRWifiForm();
    super.initState();
  }

  void _onChanged(_WifiField field, dynamic _) {
    switch (field) {
      case _WifiField.ssid:
        form.ssid = _;
        break;
      case _WifiField.encryption:
        form.encryption = _;
        break;
      case _WifiField.hidden:
        form.hidden = _;
        break;
      case _WifiField.password:
        form.password = _;
        break;
      default:
        break;
    }
    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.wifi,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            prefixIcon: PrefixIcon(icon: AppAssets.instance.gWifi),
            hintText: "Network SSID (Name)",
            onChanged: (_) => _onChanged(_WifiField.ssid, _),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Input(
                  prefixIcon: PrefixIcon(icon: AppAssets.instance.gText),
                  hintText: "Password",
                  onChanged: (_) => _onChanged(_WifiField.password, _),
                ),
              ),
              _HiddenCheckBox(
                value: form.hidden,
                onChanged: (_) => _onChanged(_WifiField.hidden, _),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.instance.padding),
          _EncryptionSelect(
            value: form.encryption,
            onChanged: (_) => _onChanged(_WifiField.encryption, _),
          ),
        ],
      ),
    );
  }
}

class _HiddenCheckBox extends StatefulWidget {
  const _HiddenCheckBox({required this.value, required this.onChanged});
  final bool value;
  final Function(bool) onChanged;

  @override
  State<_HiddenCheckBox> createState() => __HiddenCheckBoxState();
}

class __HiddenCheckBoxState extends State<_HiddenCheckBox> {
  bool hidden = false;

  @override
  void initState() {
    hidden = widget.value;
    super.initState();
  }

  void _onChanged(bool? _) {
    if (_ == null) return;
    setState(() {
      hidden = _;
    });
    widget.onChanged(_);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: hidden,
          onChanged: _onChanged,
        ),
        Text("Hidden", style: Theme.of(context).textTheme.bodyLarge)
      ],
    );
  }
}

class _EncryptionSelect extends StatefulWidget {
  const _EncryptionSelect({required this.value, required this.onChanged});
  final Encryption value;
  final Function(Encryption) onChanged;

  @override
  State<_EncryptionSelect> createState() => __EncryptionSelectState();
}

class __EncryptionSelectState extends State<_EncryptionSelect> {
  Encryption encryption = Encryption.wpa;

  @override
  void initState() {
    encryption = widget.value;
    super.initState();
  }

  void _onChanged(Encryption? _) {
    if (_ == null) return;
    setState(() {
      encryption = _;
    });
    widget.onChanged(_);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: Encryption.values
          .map(
            (_) => Container(
              margin: EdgeInsets.only(
                right: AppDimensions.instance.padding,
              ),
              child: Row(
                children: [
                  Radio<Encryption>(
                    value: _,
                    groupValue: encryption,
                    onChanged: _onChanged,
                  ),
                  Text(
                    _.label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
