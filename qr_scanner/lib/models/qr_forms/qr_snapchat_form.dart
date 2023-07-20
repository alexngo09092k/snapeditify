// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRSnapChatType {
  profile,
  tweet,
}

class QRSnapChatForm extends QRFormBase {
  String username;
  String tweet;
  QRSnapChatType type;

  QRSnapChatForm({
    this.username = "",
    this.tweet = "",
    this.type = QRSnapChatType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRSnapChatType.profile:
        return "https://twitter.com/$username";
      case QRSnapChatType.tweet:
        return "https://twitter.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRSnapChatType.profile:
        return username.isNotEmpty;
      case QRSnapChatType.tweet:
        return tweet.isNotEmpty;
    }
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'smsto:',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}

extension QRSnapChatTypeEx on QRSnapChatType {
  String get label {
    switch (this) {
     case QRSnapChatType.profile:
        return "Link to your profile";
      case QRSnapChatType.tweet:
        return "Post a tweet";
    }
  }
}
