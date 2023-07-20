// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRDouyinType {
  profile,
  tweet,
}

class QRDouyinForm extends QRFormBase {
  String username;
  String tweet;
  QRDouyinType type;

  QRDouyinForm({
    this.username = "",
    this.tweet = "",
    this.type = QRDouyinType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRDouyinType.profile:
        return "https://www.douyin.com/$username";
      case QRDouyinType.tweet:
        return "https://www.douyin.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRDouyinType.profile:
        return username.isNotEmpty;
      case QRDouyinType.tweet:
        return tweet.isNotEmpty;
    }
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://www.douyin.com',
      'https://douyin.com',
      'http://douyin.com',
      'douyin:',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}

extension QRDouyinTypeEx on QRDouyinType {
  String get label {
    switch (this) {
      case QRDouyinType.profile:
        return "Link to your profile";
      case QRDouyinType.tweet:
        return "Post a tweet";
    }
  }
}
