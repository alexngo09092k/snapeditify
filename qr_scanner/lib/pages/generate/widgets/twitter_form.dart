import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_twitter_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _TwitterField {
  type,
  username,
  tweet,
}

class TwitterForm extends StatefulWidget {
  const TwitterForm({super.key});

  @override
  State<TwitterForm> createState() => _TwitterFormState();
}

class _TwitterFormState extends BaseFormState<TwitterForm, QRTwitterForm> {
  @override
  void initState() {
    form = QRTwitterForm();
    super.initState();
  }

  void _onChanged(_TwitterField field, dynamic _) {
    switch (field) {
      case _TwitterField.type:
        form.type = _;
        break;
      case _TwitterField.tweet:
        form.tweet = _;
        break;
      case _TwitterField.username:
        form.username = _;
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
      child: _QRTwitterTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_TwitterField.type, _),
        builder: (_, type) => type == QRTwitterType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_TwitterField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_TwitterField.tweet, _),
              ),
      ),
    );
  }
}

class _QRTwitterTypeSelect extends StatefulWidget {
  const _QRTwitterTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRTwitterType value;
  final Function(QRTwitterType) onChanged;
  final Widget Function(BuildContext context, QRTwitterType) builder;

  @override
  State<_QRTwitterTypeSelect> createState() => __QRTwitterTypeSelectState();
}

class __QRTwitterTypeSelectState extends State<_QRTwitterTypeSelect> {
  QRTwitterType type = QRTwitterType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRTwitterType? _) {
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
          children: QRTwitterType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRTwitterType>(
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
