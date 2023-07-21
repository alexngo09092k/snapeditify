import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/pages/generate/widgets/crypto_form.dart';
import 'package:qr_scanner/pages/generate/widgets/douyin_form.dart';
import 'package:qr_scanner/pages/generate/widgets/email_form.dart';
import 'package:qr_scanner/pages/generate/widgets/event_form.dart';
import 'package:qr_scanner/pages/generate/widgets/facebook_form.dart';
import 'package:qr_scanner/pages/generate/widgets/generate_item.dart';
import 'package:qr_scanner/pages/generate/widgets/instagram_form.dart';
import 'package:qr_scanner/pages/generate/widgets/map_form.dart';
import 'package:qr_scanner/pages/generate/widgets/phone_form.dart';
import 'package:qr_scanner/pages/generate/widgets/product_form.dart';
import 'package:qr_scanner/pages/generate/widgets/sms_form.dart';
import 'package:qr_scanner/pages/generate/widgets/snapchat_form.dart';
import 'package:qr_scanner/pages/generate/widgets/telegram_form.dart';
import 'package:qr_scanner/pages/generate/widgets/text_form.dart';
import 'package:qr_scanner/pages/generate/widgets/link_form.dart';
import 'package:qr_scanner/pages/generate/widgets/tiktok_form.dart';
import 'package:qr_scanner/pages/generate/widgets/twitter_form.dart';
import 'package:qr_scanner/pages/generate/widgets/vcard_form.dart';
import 'package:qr_scanner/pages/generate/widgets/whatsapp_form.dart';
import 'package:qr_scanner/pages/generate/widgets/wifi_form.dart';
import 'package:qr_scanner/pages/generate/widgets/youtube_form.dart';
import 'package:qr_scanner/utils/widget.dart';
import 'package:qr_scanner/widgets/app_use/app_layout.dart';

class GeneratePage extends StatelessWidget {
  const GeneratePage({super.key});

  void _onQRType(BuildContext context, QRType type) {
    WidgetUtils.instance.showDialog(
      barrierDismissible: false,
      barrierColor: Theme.of(context).colorScheme.background,
      builder: (_) {
        switch (type) {
          case QRType.link:
            return const LinkForm();
          case QRType.text:
            return const TextForm();
          case QRType.email:
            return const EmailForm();
          case QRType.tel:
            return const PhoneForm();
          case QRType.sms:
            return const SMSForm();
          case QRType.vcard:
            return const VCardForm();
          case QRType.maps:
            return const MapForm();
          case QRType.facebook:
            return const FacebookForm();
          case QRType.twitter:
            return const TwitterForm();
          case QRType.youtube:
            return const YoutubeForm();
          case QRType.instagram:
            return const InstagramForm();
          case QRType.snapchat:
            return const SnapChatForm();
          case QRType.telegram:
            return const TelegramForm();
          case QRType.tiktok:
            return const TikTokForm();
          case QRType.douyin:
            return const DouyinForm();
          case QRType.wifi:
            return const WifiForm();
          case QRType.event:
            return const EventForm();
          case QRType.crypto:
            return const CryptoForm();
          case QRType.product:
            return const ProductForm();
          case QRType.whatsapp:
            return const WhatsAppForm();
          default:
            return const SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: "Generate",
      appBar: true,
      back: false,
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(
              bottom: 100,
              left: AppDimensions.instance.padding,
              right: AppDimensions.instance.padding,
              top: AppDimensions.instance.padding,
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
    );
  }
}
