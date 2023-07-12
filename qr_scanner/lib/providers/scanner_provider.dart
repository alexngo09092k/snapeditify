import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_data.dart';
import 'package:qr_scanner/models/qr_data_type.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/models/scanner_settings.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:qr_scanner/providers/storage_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

abstract class IScannerProvider extends StorageProvider with Provider {
  MobileScannerController get controller;

  ScannerSettings get settings;

  void onDetect(BarcodeCapture capture);

  void onStarted(MobileScannerArguments? arguments);

  void onZoom(double scale);

  void onGallery();

  void onFlashlight();

  void onCameraFacing();
}

class ScannerProvider extends IScannerProvider with ProviderDelegate {
  late MobileScannerController _controller;
  late ScannerSettings _settings;

  @override
  MobileScannerController get controller => _controller;

  @override
  ScannerSettings get settings => _settings;

  @override
  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if(barcode.rawValue == null) continue;
      if(HistoryProvider.instance.isExists(QRDataType.isScanned, barcode.rawValue!)) break;
      final QRType? type = checkQRType(barcode);
      if(type == null) continue;
      final QRData qrData = QRData(
        qrData: barcode.rawValue!, 
        qrType: type, 
        type: QRDataType.isScanned, 
        lastModified: DateTime.now(), 
        image: capture.image,
      );
      HistoryProvider.instance.addQRData(qrData);
    }
  }

  @override
  void onFlashlight() {
    _controller.toggleTorch();
  }

  @override
  void onCameraFacing() {
    _controller.switchCamera();
  }

  @override
  void onZoom(double scale) {
    _controller.setZoomScale(scale);
  }

  @override
  void onGallery() {}

  @override
  void onStarted(MobileScannerArguments? arguments) {}

  @override
  void clean([bool notify = false]) {
    _controller.hasTorchState.removeListener(_onSettingsChanged);
    _controller.cameraFacingState.removeListener(_onSettingsChanged);

    _settings = ScannerSettings();
    _controller = MobileScannerController(
      facing: _settings.facing,
      detectionSpeed: _settings.detectionSpeed,
      detectionTimeoutMs: _settings.detectionTimeoutMs,
      torchEnabled: _settings.torchEnabled,
      formats: _settings.formats,
      returnImage: _settings.returnImage,
      autoStart: _settings.autoStart,
    );
    _controller.hasTorchState.addListener(_onSettingsChanged);
    _controller.cameraFacingState.addListener(_onSettingsChanged);

    if (notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);
    return AsyncStorage.instance.remove(AsyncStorageKey.instance.scannerSettings);
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {}

  @override
  void syncFromStorage([bool notify = false]) {
    String? scannerSettingsString = AsyncStorage.instance.getString(AsyncStorageKey.instance.scannerSettings);
    Debug.log("============= SCANNER SETTINGS $scannerSettingsString ============");
    _settings = scannerSettingsString != null? ScannerSettings.fromJson(scannerSettingsString): ScannerSettings();
    _controller = MobileScannerController(
      facing: _settings.facing,
      detectionSpeed: _settings.detectionSpeed,
      detectionTimeoutMs: _settings.detectionTimeoutMs,
      torchEnabled: _settings.torchEnabled,
      formats: _settings.formats,
      returnImage: _settings.returnImage,
      autoStart: _settings.autoStart,
    );
    _controller.hasTorchState.addListener(_onSettingsChanged);
    _controller.cameraFacingState.addListener(_onSettingsChanged);

    if (notify) notifyListeners();
  }

  @override
  Future<void> syncToStorage([bool notify = false]) {
    return AsyncStorage.instance.setString(AsyncStorageKey.instance.scannerSettings, _settings.toJson());
  }

  void _onSettingsChanged() {
    _settings.torchEnabled = _controller.torchEnabled;
    _settings.facing = _controller.facing;
    syncFromStorage();
  }

  @override
  Future<bool> registered() async {
    syncFromStorage(true);
    return super.registered();
  }

  @override
  void dispose() {
    _controller.hasTorchState.removeListener(_onSettingsChanged);
    _controller.cameraFacingState.removeListener(_onSettingsChanged);
    _controller.dispose();
    super.dispose();
  }
}

extension ScannerProviderEx on ScannerProvider {
  QRType? checkQRType(Barcode barcode) {
    if(barcode.contactInfo != null) return QRType.contacts;
    if(barcode.email != null) return QRType.mail;
    if(barcode.calendarEvent != null) return QRType.calendar;
    if(barcode.phone != null) return QRType.tel;
    if(barcode.url != null) return QRType.website;
    if(barcode.sms != null) return QRType.sms;
    if(barcode.wifi != null) return QRType.wifi;
    // if(barcode.geoPoint != null) return QRType. 
    // if(barcode.driverLicense != null) return QRType.
    return null;
  }
}
