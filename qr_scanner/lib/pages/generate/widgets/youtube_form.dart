import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_youtube_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _YoutubeField {
  type,
  username,
  tweet,
}

class YoutubeForm extends StatefulWidget {
  const YoutubeForm({super.key});

  @override
  State<YoutubeForm> createState() => _YoutubeFormState();
}

class _YoutubeFormState extends State<YoutubeForm> {
  final ValueNotifier<bool> _isDisabled = ValueNotifier(true);
  final QRYoutubeForm _form = QRYoutubeForm();

  @override
  void initState() {
    _isDisabled.value = !_form.validate();
    super.initState();
  }

  String? onData() => _form.buildQRRawData();

  void _onChanged(_YoutubeField field, dynamic _) {
    switch (field) {
      case _YoutubeField.type:
        _form.type = _;
        break;
      case _YoutubeField.tweet:
        _form.tweet = _;
        break;
      case _YoutubeField.username:
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
      child: _QRYoutubeTypeSelect(
        value: _form.type,
        onChanged: (_) => _onChanged(_YoutubeField.type, _),
        builder: (_, type) => type == QRYoutubeType.profile
            ? Input(
                hintText: "@username",
                onChanged: (_) => _onChanged(_YoutubeField.username, _),
              )
            : Input(
                hintText: "Compose your tweet",
                onChanged: (_) => _onChanged(_YoutubeField.tweet, _),
              ),
      ),
    );
  }
}

class _QRYoutubeTypeSelect extends StatefulWidget {
  const _QRYoutubeTypeSelect({
    required this.value,
    required this.onChanged,
    required this.builder,
  });
  final QRYoutubeType value;
  final Function(QRYoutubeType) onChanged;
  final Widget Function(BuildContext context, QRYoutubeType) builder;

  @override
  State<_QRYoutubeTypeSelect> createState() => __QRYoutubeTypeSelectState();
}

class __QRYoutubeTypeSelectState extends State<_QRYoutubeTypeSelect> {
  QRYoutubeType type = QRYoutubeType.profile;

  @override
  void initState() {
    type = widget.value;
    super.initState();
  }

  void _onChanged(QRYoutubeType? _) {
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
          children: QRYoutubeType.values
              .map(
                (_) => Container(
                  margin: EdgeInsets.only(
                    right: AppDimensions.instance.padding,
                  ),
                  child: Row(
                    children: [
                      Radio<QRYoutubeType>(
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
