// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRWhatsAppType {
  profile,
  tweet,
}

class QRWhatsAppForm extends QRFormBase {
  String username;
  String tweet;
  QRWhatsAppType type;

  QRWhatsAppForm({
    this.username = "",
    this.tweet = "",
    this.type = QRWhatsAppType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRWhatsAppType.profile:
        return "https://whatsapp.com/$username";
      case QRWhatsAppType.tweet:
        return "https://whatsapp.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRWhatsAppType.profile:
        return username.isNotEmpty;
      case QRWhatsAppType.tweet:
        return tweet.isNotEmpty;
    }
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://twitter.com',
      'https://www.twitter.com',
      'http://www.twitter.com',
      'http://twitter.com',
      'twitter:'
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}

extension QRWhatsAppTypeEx on QRWhatsAppType {
  String get label {
    switch (this) {
      case QRWhatsAppType.profile:
        return "Link to your profile";
      case QRWhatsAppType.tweet:
        return "Post a tweet";
    }
  }
}
