import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_douyin_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _DouyinField {
  type,
  username,
  tweet,
}

class DouyinForm extends StatefulWidget {
  const DouyinForm({super.key});

  @override
  State<DouyinForm> createState() => _DouyinFormState();
}

class _DouyinFormState extends State<DouyinForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRDouyinForm _form = QRDouyinForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_DouyinField field, dynamic _) {
    switch (field) {
      case _DouyinField.type:
        _form.type = _;
        break;
      case _DouyinField.tweet:
        _form.tweet = _;
        break;
      case _DouyinField.username:
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
      child: _QRDouyinTypeSelect(
        value: _form.type,
        onChanged: (_) => _onChanged(_DouyinField.type, _),
        builder: (_, type) => type == QRDouyinType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_DouyinField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_DouyinField.tweet, _),
              ),
      ),
    );
  }
}

class _QRDouyinTypeSelect extends StatefulWidget {
  const _QRDouyinTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRDouyinType value;
  final Function(QRDouyinType) onChanged;
  final Widget Function(BuildContext context, QRDouyinType) builder;

  @override
  State<_QRDouyinTypeSelect> createState() => __QRDouyinTypeSelectState();
}

class __QRDouyinTypeSelectState extends State<_QRDouyinTypeSelect> {
  QRDouyinType type = QRDouyinType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRDouyinType? _) {
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
          children: QRDouyinType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRDouyinType>(
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
