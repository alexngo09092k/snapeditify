// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRTelegramType {
  profile,
  tweet,
}

class QRTelegramForm extends QRFormBase {
  String username;
  String tweet;
  QRTelegramType type;

  QRTelegramForm({
    this.username = "",
    this.tweet = "",
    this.type = QRTelegramType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRTelegramType.profile:
        return "https://twitter.com/$username";
      case QRTelegramType.tweet:
        return "https://twitter.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRTelegramType.profile:
        return username.isNotEmpty;
      case QRTelegramType.tweet:
        return tweet.isNotEmpty;
    }
  }
}

extension QRTelegramTypeEx on QRTelegramType {
  String get label {
    switch (this) {
     case QRTelegramType.profile:
        return "Link to your profile";
      case QRTelegramType.tweet:
        return "Post a tweet";
    }
  }
}
