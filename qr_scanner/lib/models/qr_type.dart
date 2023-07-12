import 'package:qr_scanner/common/constants.dart';

enum QRType {
  website,
  wifi,
  text,
  contacts,
  tel,
  mail,
  sms,
  calendar,
  card,
  tiktok,
  douyin,
  webchat,
  weibo,
  facebook,
  instagram,
  whatsapp,
  youtube,
  twitter,
  spotify,
  paypal,
  viber,
}

extension QRTypeEx on QRType {
  String get icon {
    switch (this) {
      case QRType.website:
        return AppAssets.instance.logo;
      case QRType.wifi:
        return AppAssets.instance.logo;
      case QRType.text:
        return AppAssets.instance.logo;
      case QRType.contacts:
        return AppAssets.instance.logo;
      case QRType.tel:
        return AppAssets.instance.logo;
      case QRType.mail:
        return AppAssets.instance.logo;
      case QRType.sms:
        return AppAssets.instance.logo;
      case QRType.calendar:
        return AppAssets.instance.logo;
      case QRType.card:
        return AppAssets.instance.logo;
      case QRType.tiktok:
        return AppAssets.instance.logo;
      case QRType.douyin:
        return AppAssets.instance.logo;
      case QRType.webchat:
        return AppAssets.instance.logo;
      case QRType.weibo:
        return AppAssets.instance.logo;
      case QRType.facebook:
        return AppAssets.instance.logo;
      case QRType.instagram:
        return AppAssets.instance.logo;
      case QRType.whatsapp:
        return AppAssets.instance.logo;
      case QRType.youtube:
        return AppAssets.instance.logo;
      case QRType.twitter:
        return AppAssets.instance.logo;
      case QRType.spotify:
        return AppAssets.instance.logo;
      case QRType.paypal:
        return AppAssets.instance.logo;
      case QRType.viber:
        return AppAssets.instance.logo;
      default:
        throw 'Not found Icon of QR Type';
    }
  }

  String get label {
    switch (this) {
      case QRType.website:
        return "Website";
      case QRType.wifi:
        return "Wi-fi";
      case QRType.text:
        return "Text";
      case QRType.contacts:
        return "Contacts";
      case QRType.tel:
        return "Tel";
      case QRType.mail:
        return "Mail";
      case QRType.sms:
        return "SMS";
      case QRType.calendar:
        return "Calendar";
      case QRType.card:
        return "Card";
      case QRType.tiktok:
        return "Tiktok";
      case QRType.douyin:
        return "Douyin";
      case QRType.webchat:
        return "Webchat";
      case QRType.weibo:
        return "Weibo";
      case QRType.facebook:
        return "Facebook";
      case QRType.instagram:
        return "Instagram";
      case QRType.whatsapp:
        return "Whatsapp";
      case QRType.youtube:
        return "Youtube";
      case QRType.twitter:
        return "Twitter";
      case QRType.spotify:
        return "Spotify";
      case QRType.paypal:
        return "Paypal";
      case QRType.viber:
        return "Viber";
      default:
        throw 'Not found Label of QR Type';
    }
  }
}
