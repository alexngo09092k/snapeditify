import 'package:qr_scanner/common/constants.dart';

enum QRType {
  link,
  text,
  email,
  tel,
  sms,
  vcard,
  maps,
  facebook,
  twitter,
  youtube,
  instagram,
  snapchat,
  whatsapp,
  telegram,
  tiktok,
  douyin,
  wifi,
  event,
  crypto,
  // pdf,
  // audio,
  // pptx,
  // image,
  // store,
  // pcr,
  // linkList,
  // mutilurl,
  // menu,
  // contact,
}

extension QRTypeEx on QRType {
  String get icon {
    switch (this) {
      case QRType.crypto:
        return AppAssets.instance.gCrypto;
      case QRType.email:
        return AppAssets.instance.gEmail;
      case QRType.facebook:
        return AppAssets.instance.gFacebook;

      case QRType.instagram:
        return AppAssets.instance.gInstagram;
      case QRType.vcard:
        return AppAssets.instance.gVCard;

      case QRType.link:
        return AppAssets.instance.gLink;
      case QRType.maps:
        return AppAssets.instance.gMaps;

      case QRType.snapchat:
        return AppAssets.instance.gSnapChat;

      case QRType.telegram:
        return AppAssets.instance.gTelegram;
      case QRType.text:
        return AppAssets.instance.gText;
      case QRType.tiktok:
        return AppAssets.instance.gTiktok;
      case QRType.douyin:
        return AppAssets.instance.gTiktok;
      case QRType.twitter:
        return AppAssets.instance.gTwitter;
      case QRType.whatsapp:
        return AppAssets.instance.gWhatsapp;
      case QRType.wifi:
        return AppAssets.instance.gWifi;
      case QRType.youtube:
        return AppAssets.instance.gYoutube;
      case QRType.sms:
        return AppAssets.instance.gEmail;

      case QRType.tel:
        return AppAssets.instance.gEmail;
      case QRType.event:
        return AppAssets.instance.gEmail;
      // case QRType.linkList:
      //   return AppAssets.instance.gLinkList;
      // case QRType.image:
      //   return AppAssets.instance.gImage;
      // case QRType.audio:
      //   return AppAssets.instance.gAudio;
      // case QRType.menu:
      //   return AppAssets.instance.gMenu;
      // case QRType.mutilurl:
      //   return AppAssets.instance.gMutilUrl;
      // case QRType.pcr:
      //   return AppAssets.instance.gPCR;
      // case QRType.pdf:
      //   return AppAssets.instance.gPDF;
      // case QRType.pptx:
      //   return AppAssets.instance.gPPTX;
      // case QRType.store:
      //   return AppAssets.instance.gStore;
      // case QRType.contact:
      //   return AppAssets.instance.gEmail;
    }
  }

  String get label {
    switch (this) {
      case QRType.crypto:
        return "Crypto Payment";
      case QRType.email:
        return "E-mail";
      case QRType.facebook:
        return "Facebook";
      case QRType.instagram:
        return "Instagram";
      case QRType.vcard:
        return "vCard";
      case QRType.link:
        return "URL";
      case QRType.maps:
        return "Google Maps";
      case QRType.snapchat:
        return "Snapchat";
      case QRType.telegram:
        return "Telegram";
      case QRType.text:
        return "Text";
      case QRType.tiktok:
        return "Tiktok";
      case QRType.douyin:
        return "Douyin";
      case QRType.twitter:
        return "Twitter";
      case QRType.whatsapp:
        return "Whatsapp";
      case QRType.wifi:
        return "Wi-fi";
      case QRType.youtube:
        return "Youtube";
      case QRType.sms:
        return "SMS";
      case QRType.tel:
        return "Phone";
      case QRType.event:
        return "Event";
      // case QRType.store:
      //   return "App Store & Google Play";
      // case QRType.linkList:
      //   return "List of Links";
      // case QRType.image:
      //   return "Image";
      // case QRType.audio:
      //   return "Audio";
      // case QRType.menu:
      //   return "Menu";
      // case QRType.mutilurl:
      //   return "Customizable URL";
      // case QRType.pcr:
      //   return "PCR";
      // case QRType.pdf:
      //   return "PDF";
      // case QRType.pptx:
      //   return "PPTX";
      // case QRType.contact:
      //   return "Contact";
    }
  }
}
