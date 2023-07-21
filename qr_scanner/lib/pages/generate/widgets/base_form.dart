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
  });

  final QRType qrType;
  final Widget child;
  final String? Function() onData;
  final Function(QRFormat)? onQRFormat;
  final ValueNotifier<bool>? isDisabled;

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
                  children: [
                    widget.child,
                    if (canChangeFormat)
                      AnimatedBuilder(
                        animation: format,
                        builder: (_, __) => Column(
                          children: [
                            SizedBox(height: AppDimensions.instance.padding),
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: QRFormat.values.length,
                                itemBuilder: (_, __) => GestureDetector(
                                  onTap: () => onFormatChanged(QRFormat.values[__]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                                      border: Border.all(
                                        width: 3,
                                        color: format.value == QRFormat.values[__]
                                            ? Theme.of(context).colorScheme.primary
                                            : Theme.of(context).disabledColor,
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: AppDimensions.instance.padding,
                                      horizontal: AppDimensions.instance.paddingX(0.5),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.instance.padding,
                                      vertical: AppDimensions.instance.paddingX(0.5),
                                    ),
                                    child: Text(
                                      QRFormat.values[__].label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: format.value == QRFormat.values[__]
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : null,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
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
                ? AnimatedBuilder(
                    animation: widget.isDisabled!,
                    builder: (_, __) => CustomButton(
                      title: "Generate",
                      onTap: onGenerate,
                      height: 50,
                      isDisabled: widget.isDisabled!.value,
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
