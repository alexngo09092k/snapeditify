// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

enum QRYoutubeType {
  url,
  videoId,
  chanelId,
}

class QRYoutubeForm extends QRFormBase {
  String videoId;
  String chanelId;
  String url;
  QRYoutubeType type;

  QRYoutubeForm({
    this.videoId = "",
    this.chanelId = "",
    this.url = "",
    this.type = QRYoutubeType.url,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    switch (type) {
      case QRYoutubeType.url:
        return url;
      case QRYoutubeType.videoId:
        return "https://youtube.com/watch?v=$videoId";
      case QRYoutubeType.chanelId:
        return "https://twitter.com/intent/chanelId?text=$chanelId";
    }
  }

  @override
  bool validate() {
    switch (type) {
      case QRYoutubeType.url:
        return QRUtils.instance.isURL(url);
      case QRYoutubeType.videoId:
        return videoId.isNotEmpty;
      case QRYoutubeType.chanelId:
        return chanelId.isNotEmpty;
    }
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'https://youtube.com',
      'https://www.youtube.com',
      'http://youtube.com',
      'http://www.youtube.com',
      'youtube:',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}

extension QRYoutubeTypeEx on QRYoutubeType {
  String get label {
    switch (this) {
      case QRYoutubeType.url:
        return "URL";
      case QRYoutubeType.videoId:
        return "Video ID";
      case QRYoutubeType.chanelId:
        return "Chanel ID";
    }
  }
}
