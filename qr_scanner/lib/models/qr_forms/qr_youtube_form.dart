// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

enum QRYoutubeType {
  profile,
  tweet,
}

class QRYoutubeForm extends QRFormBase {
  String username;
  String tweet;
  QRYoutubeType type;

  QRYoutubeForm({
    this.username = "",
    this.tweet = "",
    this.type = QRYoutubeType.profile,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRYoutubeType.profile:
        return "https://youtube.com/$username";
      case QRYoutubeType.tweet:
        return "https://twitter.com/intent/tweet?text=$tweet";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRYoutubeType.profile:
        return username.isNotEmpty;
      case QRYoutubeType.tweet:
        return tweet.isNotEmpty;
    }
  }
}

extension QRYoutubeTypeEx on QRYoutubeType {
  String get label {
    switch (this) {
     case QRYoutubeType.profile:
        return "Link to your profile";
      case QRYoutubeType.tweet:
        return "Post a tweet";
    }
  }
}
