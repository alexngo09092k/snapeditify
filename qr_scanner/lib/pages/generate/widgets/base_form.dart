import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/app_routes.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_format.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:qr_scanner/widgets/base/custom_button.dart';
import 'package:qr_scanner/widgets/base/custom_icon.dart';

class BaseForm extends StatefulWidget {
  const BaseForm({
    super.key,
    required this.qrType,
    required this.child,
    required this.onData,
    this.isDisabled,
    this.onQRFormat,
    this.disableQRFormats = const [],
  });

  final QRType qrType;
  final Widget child;
  final String? Function() onData;
  final Function(QRFormat)? onQRFormat;
  final ValueNotifier<bool>? isDisabled;
  final List<QRFormat> disableQRFormats;

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  final ValueNotifier<QRFormat> format = ValueNotifier(QRFormat.QrCode);

  bool get canChangeFormat {
    switch (widget.qrType) {
      case QRType.crypto:
      case QRType.email:
      case QRType.facebook:
      case QRType.instagram:
      case QRType.vcard:
      case QRType.link:
      case QRType.maps:
      case QRType.snapchat:
      case QRType.telegram:
      case QRType.tiktok:
      case QRType.douyin:
      case QRType.twitter:
      case QRType.whatsapp:
      case QRType.wifi:
      case QRType.youtube:
      case QRType.sms:
      case QRType.tel:
      case QRType.event:
      case QRType.text:
        // case QRType.menu:
        // case QRType.mutilurl:
        // case QRType.pcr:
        // case QRType.pdf:
        // case QRType.pptx:
        //  case QRType.image:
        // case QRType.audio:
        // case QRType.store:
        // case QRType.linkList:
        // case QRType.contact:

        return false;
      case QRType.product:
        return true;
    }
  }

  void onGenerate() {
    final String? data = widget.onData();
    if (data == null) return;

    final QR qr = QR(
      rawData: data,
      type: widget.qrType,
      source: QRSource.generate,
      lastModified: DateTime.now(),
      format: format.value,
    );

    HistoryProvider.instance.addQR(qr);

    AwesomeAppState.dimiss();

    Navigator.of(context).pushNamed(AppRoutes.viewerPage, arguments: qr);
  }

  void close() {
    AwesomeAppState.dimiss();
  }

  void onFormatChanged(QRFormat _) {
    format.value = _;
    if(widget.onQRFormat != null) widget.onQRFormat!(format.value);
  }

  @override
  Widget build(BuildContext context) {
    final formatList = QRFormat.values.where((element) => !widget.disableQRFormats.contains(element)).toList();
    return Dialog(
      alignment: Alignment.center,
      insetPadding: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Generate QR for ${widget.qrType.label}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                SizedBox(width: AppDimensions.instance.paddingX(2)),
                GestureDetector(
                  onTap: close,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: AppDimensions.instance.padding,
                      bottom: AppDimensions.instance.padding,
                    ),
                    child: CustomIcon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: AppDimensions.instance.padding),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.child,
                    if (canChangeFormat)
                      ValueListenableBuilder(
                        valueListenable: format,
                        builder: (_, value, __) => Column(
                          children: [
                            SizedBox(height: AppDimensions.instance.padding),
                            Wrap(
                              children: formatList.map((_) => GestureDetector(
                                onTap: () => onFormatChanged(_),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                                    border: Border.all(
                                      width: 1,
                                      color: value == _
                                          ? Theme.of(context).colorScheme.primary
                                          : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: AppDimensions.instance.paddingX(0.5),
                                    horizontal: AppDimensions.instance.paddingX(0.5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.instance.padding,
                                    vertical: AppDimensions.instance.paddingX(0.5),
                                  ),
                                  child: Text(
                                    _.label,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: value == _
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : null,
                                        ),
                                  ),
                                ),
                              ),).toList()
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimensions.instance.paddingX(2)),
            widget.isDisabled != null
                ? ValueListenableBuilder(
                    valueListenable: widget.isDisabled!,
                    builder: (_, value, __) => CustomButton(
                      title: "Generate",
                      onTap: onGenerate,
                      height: 50,
                      isDisabled: value,
                    ),
                  )
                : CustomButton(
                    title: "Generate",
                    onTap: onGenerate,
                    height: 50,
                  ),
          ],
        ),
      ),
    );
  }
}
