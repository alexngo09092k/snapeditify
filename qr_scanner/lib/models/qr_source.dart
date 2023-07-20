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
    }
  }

  String get label {
    switch (this) {
      case QRSource.generate:
        return "Generate";
      case QRSource.scan:
        return "Scan";
    }
  }
}
