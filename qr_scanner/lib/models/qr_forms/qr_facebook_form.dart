// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRFacebookType {
  profile,
  share,
}

class QRFacebookForm extends QRFormBase {
  String username;
  String shareURL;
  QRFacebookType type;

  QRFacebookForm({
    this.username = "",
    this.shareURL = "",
    this.type = QRFacebookType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRFacebookType.profile:
        return "http://facebook.com/$username";
      case QRFacebookType.share:
        return "https://www.facebook.com/sharer/sharer.php?u=$shareURL";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRFacebookType.profile:
        return username.isNotEmpty;
      case QRFacebookType.share:
        return shareURL.isNotEmpty;
    }
  }
}

extension QRFacebookTypeEx on QRFacebookType {
  String get label {
    switch (this) {
     case QRFacebookType.profile:
        return "Link to your profile";
      case QRFacebookType.share:
        return "Share your URL on Facebook";
    }
  }
}
