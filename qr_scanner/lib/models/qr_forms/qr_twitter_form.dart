// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRTwitterType {
  profile,
  tweet,
}

class QRTwitterForm extends QRFormBase {
  String username;
  String tweet;
  QRTwitterType type;

  QRTwitterForm({
    this.username = "",
    this.tweet = "",
    this.type = QRTwitterType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRTwitterType.profile:
        return "https://twitter.com/$username";
      case QRTwitterType.tweet:
        return "https://twitter.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRTwitterType.profile:
        return username.isNotEmpty;
      case QRTwitterType.tweet:
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

extension QRTwitterTypeEx on QRTwitterType {
  String get label {
    switch (this) {
      case QRTwitterType.profile:
        return "Link to your profile";
      case QRTwitterType.tweet:
        return "Post a tweet";
    }
  }
}
