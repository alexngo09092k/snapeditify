import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_forms/qr_youtube_form.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form.dart';
import 'package:qr_scanner/pages/generate/widgets/base_form_state.dart';
import 'package:qr_scanner/pages/generate/widgets/prefix_icon.dart';
import 'package:qr_scanner/widgets/app_use/input.dart';

enum _YoutubeField {
  type,
  videoId,
  chanelId,
  url,
}

class YoutubeForm extends StatefulWidget {
  const YoutubeForm({super.key});

  @override
  State<YoutubeForm> createState() => _YoutubeFormState();
}

class _YoutubeFormState extends BaseFormState<YoutubeForm, QRYoutubeForm> {
  @override
  void initState() {
    form = QRYoutubeForm();
    super.initState();
  }

  void _onChanged(_YoutubeField field, dynamic _) {
    switch (field) {
      case _YoutubeField.type:
        form.type = _;
        break;
      case _YoutubeField.chanelId:
        form.chanelId = _;
        break;
      case _YoutubeField.videoId:
        form.videoId = _;
        break;
      case _YoutubeField.url:
        form.url = _;
        break;
    }

    checkDisabled();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      onData: onData,
      qrType: QRType.youtube,
      isDisabled: isDisabled,
      child: _QRYoutubeTypeSelect(
        value: form.type,
        onChanged: (_) => _onChanged(_YoutubeField.type, _),
        builder: (_, type) => type == QRYoutubeType.url
            ? Input(
                prefixIcon: PrefixIcon(icon: AppAssets.instance.gYoutube),
                hintText: "URL",
                onChanged: (_) => _onChanged(_YoutubeField.url, _),
              )
            : (type == QRYoutubeType.videoId
                ? Input(
                    prefixIcon: PrefixIcon(icon: AppAssets.instance.gYoutube),
                    hintText: "Video ID",
                    onChanged: (_) => _onChanged(_YoutubeField.videoId, _),
                  )
                : Input(
                    prefixIcon: PrefixIcon(icon: AppAssets.instance.gYoutube),
                    hintText: "",
                    onChanged: (_) => _onChanged(_YoutubeField.chanelId, _),
                  )),
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
  QRYoutubeType type = QRYoutubeType.url;

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
        ...QRYoutubeType.values
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
        SizedBox(height: AppDimensions.instance.padding),
        widget.builder(context, type),
      ],
    );
  }
}
