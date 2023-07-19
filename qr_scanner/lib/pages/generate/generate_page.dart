import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/crypto_form.dart';
import 'package:qr_scanner/pages/generate/widgets/email_form.dart';
import 'package:qr_scanner/pages/generate/widgets/facebook_form.dart';
import 'package:qr_scanner/pages/generate/widgets/generate_item.dart';
import 'package:qr_scanner/pages/generate/widgets/instagram_form.dart';
import 'package:qr_scanner/pages/generate/widgets/map_form.dart';
import 'package:qr_scanner/pages/generate/widgets/snapchat.dart';
import 'package:qr_scanner/pages/generate/widgets/store_form.dart';
import 'package:qr_scanner/pages/generate/widgets/telegram_form.dart';
import 'package:qr_scanner/pages/generate/widgets/text_form.dart';
import 'package:qr_scanner/pages/generate/widgets/url_form.dart';
import 'package:qr_scanner/pages/generate/widgets/wifi_form.dart';
import 'package:qr_scanner/utils/widget.dart';

class GeneratePage extends StatelessWidget {
  const GeneratePage({super.key});

  void _onQRType(BuildContext context, QRType type) {
    WidgetUtils.instance.showDialog(
      barrierDismissible: false,
      barrierColor: Theme.of(context).colorScheme.background,
      builder: (_) {
        switch (type) {
          case QRType.link:
            return const URLForm();
          case QRType.wifi:
            return const WifiForm();
          case QRType.email:
            return const EmailForm();
          case QRType.text:
            return const TextForm();
          case QRType.store:
            return const StoreForm();
          case QRType.instagram:
            return const InstagramForm();
          case QRType.facebook:
            return const FacebookForm();
          case QRType.tiktok:
            return const FacebookForm();
          case QRType.snapchat:
            return const SnapchatForm();
          case QRType.telegram:
            return const TelegramForm();
          case QRType.maps:
            return const MapForm();
          case QRType.crypto:
            return const CryptoForm();
          default:
            return const SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  bottom: 100,
                  left: AppDimensions.instance.padding,
                  right: AppDimensions.instance.padding,
                ),
                gridDelegate: AppDimensions.instance.gridDelegate,
                itemCount: QRType.values.length,
                itemBuilder: (_, __) => GenerateItem(
                  type: QRType.values[__],
                  onQRType: (_) => _onQRType(context, _),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
