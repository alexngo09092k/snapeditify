import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_instagram_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _InstagramField {
  type,
  username,
  share,
}

class InstagramForm extends StatefulWidget {
  const InstagramForm({super.key});

  @override
  State<InstagramForm> createState() => _InstagramFormState();
}

class _InstagramFormState extends State<InstagramForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRInstagramForm _form = QRInstagramForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_InstagramField field, dynamic _) {
    switch (field) {
      case _InstagramField.type:
        _form.type = _;
        break;
      case _InstagramField.share:
        _form.shareURL = _;
        break;
      case _InstagramField.username:
        _form.username = _;
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
      child: _QRInstagramTypeSelect(
        value: _form.type,
        onChanged: (_) => _onChanged(_InstagramField.type, _),
        builder: (_, type) => type == QRInstagramType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_InstagramField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_InstagramField.share, _),
              ),
      ),
    );
  }
}

class _QRInstagramTypeSelect extends StatefulWidget {
  const _QRInstagramTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRInstagramType value;
  final Function(QRInstagramType) onChanged;
  final Widget Function(BuildContext context, QRInstagramType) builder;

  @override
  State<_QRInstagramTypeSelect> createState() => __QRInstagramTypeSelectState();
}

class __QRInstagramTypeSelectState extends State<_QRInstagramTypeSelect> {
  QRInstagramType type = QRInstagramType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRInstagramType? _) {
    if (_ == null) return;
    setState(() {
      type = _;
    });
    widget.onChanged(_);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: QRInstagramType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRInstagramType>(
                        value: _,
                        groupValue: type,
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
        ),
        widget.builder(context, type),
      ],
    );
  }
}
