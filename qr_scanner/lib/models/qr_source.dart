import 'package:qr_scanner/common/constants.dart';

enum QRSource {
  scan,
  generate,
}

extension QRSourceEx on QRSource {
  String get icon {
    switch (this) {
      case QRSource.generate:
        return AppAssets.instance.icGenerate;
      case QRSource.scan:
        return AppAssets.instance.icScanner;
      default:
        throw 'Not found Icon for QRSource';
    }
  }

  String get label {
    switch (this) {
      case QRSource.scan:
        return "Generate";
      case QRSource.generate:
        return "Scan";
      default:
        throw 'Not found Icon for QRSource';
    }
  }
}
