// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRInstagramType {
  profile,
  share,
}

class QRInstagramForm extends QRFormBase {
  String username;
  String shareURL;
  QRInstagramType type;

  QRInstagramForm({
    this.username = "",
    this.shareURL = "",
    this.type = QRInstagramType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRInstagramType.profile:
        return "https://instagram.com/$username";
      case QRInstagramType.share:
        return "https://www.facebook.com/sharer/sharer.php?u=$shareURL";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRInstagramType.profile:
        return username.isNotEmpty;
      case QRInstagramType.share:
        return shareURL.isNotEmpty;
    }
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://instagram.com',
      'https://www.instagram.com',
      'http://instagram.com',
      'http://www.instagram.com',
      'instagram:',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}

extension QRInstagramTypeEx on QRInstagramType {
  String get label {
    switch (this) {
      case QRInstagramType.profile:
        return "Link to your profile";
      case QRInstagramType.share:
        return "Share your URL on Instagram";
    }
  }
}
