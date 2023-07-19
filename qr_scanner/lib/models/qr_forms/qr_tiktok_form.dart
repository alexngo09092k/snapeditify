// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRTikTokType {
  profile,
  tweet,
}

class QRTikTokForm extends QRFormBase {
  String username;
  String tweet;
  QRTikTokType type;

  QRTikTokForm({
    this.username = "",
    this.tweet = "",
    this.type = QRTikTokType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRTikTokType.profile:
        return "https://twitter.com/$username";
      case QRTikTokType.tweet:
        return "https://twitter.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRTikTokType.profile:
        return username.isNotEmpty;
      case QRTikTokType.tweet:
        return tweet.isNotEmpty;
    }
  }
}

extension QRTikTokTypeEx on QRTikTokType {
  String get label {
    switch (this) {
     case QRTikTokType.profile:
        return "Link to your profile";
      case QRTikTokType.tweet:
        return "Post a tweet";
    }
  }
}
