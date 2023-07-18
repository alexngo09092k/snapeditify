import 'package:qr_scanner/common/constants.dart';

enum QRSource {
  isScanned,
  isGenerated,
}

extension QRSourceEx on QRSource {
  String get icon {
    switch (this) {
      case QRSource.isGenerated:
        return AppAssets.instance.icGenerate;
      case QRSource.isScanned:
        return AppAssets.instance.icScanner;
      default:
        throw 'Not found Icon for QRSource';
    }
  }

  String get label {
    switch (this) {
      case QRSource.isGenerated:
        return "Generated QR";
      case QRSource.isScanned:
        return "Scanned QR";
      default:
        throw 'Not found Icon for QRSource';
    }
  }
}
