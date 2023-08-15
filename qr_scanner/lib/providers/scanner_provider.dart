import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_format.dart';
import 'package:qr_scanner/models/qr_forms/qr_crypto_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_douyin_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_email.form.dart';
import 'package:qr_scanner/models/qr_forms/qr_event_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_facebook_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_instagram_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_link_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_map_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_phone_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_sms_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_snapchat_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_telegram_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_tiktok_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_twitter_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_vcard_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_wifi_form.dart';
import 'package:qr_scanner/models/qr_forms/qr_youtube_form.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/models/qr_type.dart';
import 'package:qr_scanner/models/scanner_settings.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:qr_scanner/providers/storage_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

abstract class IScannerProvider extends StorageProvider with Provider {
  MobileScannerController get controller;

  ScannerSettings get settings;

  ValueNotifier<BarcodeCapture?> get barcodeCapture;

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

  final ValueNotifier<BarcodeCapture?> _barcodeCapture = ValueNotifier(null);

  @override
  MobileScannerController get controller => _controller;

  @override
  ScannerSettings get settings => _settings;

  @override
  ValueNotifier<BarcodeCapture?> get barcodeCapture => _barcodeCapture;

  @override
  void onDetect(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue == null) continue;
      Debug.log(jsonEncode(barcode.rawValue));
      QRType type = checkQRType(barcode);
      QRFormat? format = checkQRFormat(barcode);
      if (format == null) continue;
      if (format != QRFormat.QrCode) type = QRType.product;
      final QR qr = QR(
        rawData: barcode.rawValue!,
        type: type,
        source: QRSource.scan,
        lastModified: DateTime.now(),
        format: format,
      );

      await Vibration.vibrate();

      if (HistoryProvider.instance.isExists(qr)) break;
      HistoryProvider.instance.addQR(qr);
    }

    if (capture.barcodes.isNotEmpty) {
      _barcodeCapture.value = capture;
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
  void onGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      if (await controller.analyzeImage(image.path)) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Barcode found!'),
        //     backgroundColor: Colors.green,
        //   ),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('No barcode found!'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
      }
    }
  }

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
  Future<void> syncToStorage() {
    return AsyncStorage.instance.setString(AsyncStorageKey.instance.scannerSettings, _settings.toJson());
  }

  void _onSettingsChanged() {
    _settings.torchEnabled = _controller.torchEnabled;
    _settings.facing = _controller.facing;
    syncToStorage();
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
  QRType checkQRType(Barcode barcode) {
    if (barcode.email != null) return QRType.email;
    if (barcode.calendarEvent != null) return QRType.event;
    if (barcode.phone != null) return QRType.tel;
    if (barcode.url != null) return QRType.link;
    if (barcode.sms != null) return QRType.sms;
    if (barcode.wifi != null) return QRType.wifi;
    if (barcode.geoPoint != null) return QRType.maps;
    if (barcode.driverLicense != null) return QRType.vcard;
    if (barcode.rawValue == null) return QRType.text;

    if (QRCryptoForm.isQR(barcode.rawValue!)) return QRType.crypto;
    if (QRDouyinForm.isQR(barcode.rawValue!)) return QRType.douyin;
    if (QREmailForm.isQR(barcode.rawValue!)) return QRType.email;
    if (QREventForm.isQR(barcode.rawValue!)) return QRType.event;
    if (QRFacebookForm.isQR(barcode.rawValue!)) return QRType.facebook;
    if (QRInstagramForm.isQR(barcode.rawValue!)) return QRType.instagram;
    if (QRMapForm.isQR(barcode.rawValue!)) return QRType.maps;
    if (QRPhoneForm.isQR(barcode.rawValue!)) return QRType.tel;
    if (QRSMSForm.isQR(barcode.rawValue!)) return QRType.sms;
    if (QRSnapChatForm.isQR(barcode.rawValue!)) return QRType.snapchat;
    if (QRTelegramForm.isQR(barcode.rawValue!)) return QRType.telegram;
    if (QRTikTokForm.isQR(barcode.rawValue!)) return QRType.tiktok;
    if (QRTwitterForm.isQR(barcode.rawValue!)) return QRType.twitter;
    if (QRVCardForm.isQR(barcode.rawValue!)) return QRType.vcard;
    if (QRWifiForm.isQR(barcode.rawValue!)) return QRType.wifi;
    if (QRYoutubeForm.isQR(barcode.rawValue!)) return QRType.youtube;

    ///
    ///
    /// GET ALL QR CHECK HERE
    ///
    ///
    if (QRLinkForm.isQR(barcode.rawValue!)) return QRType.link;

    return QRType.text;
  }

  QRFormat? checkQRFormat(Barcode barcode) {
    switch (barcode.format) {
      case BarcodeFormat.aztec:
        return QRFormat.Aztec;
      case BarcodeFormat.code128:
        return QRFormat.Code128;
      case BarcodeFormat.code39:
        return QRFormat.Code39;
      case BarcodeFormat.code93:
        return QRFormat.Code93;
      case BarcodeFormat.ean13:
        return QRFormat.CodeEAN13;
      case BarcodeFormat.ean8:
        return QRFormat.CodeEAN8;
      case BarcodeFormat.upcA:
        return QRFormat.CodeUPCA;
      case BarcodeFormat.upcE:
        return QRFormat.CodeUPCE;
      case BarcodeFormat.qrCode:
        return QRFormat.QrCode;
      case BarcodeFormat.itf:
        return QRFormat.Itf;
      case BarcodeFormat.pdf417:
        return QRFormat.PDF417;
      case BarcodeFormat.dataMatrix:
        return QRFormat.DataMatrix;
      case BarcodeFormat.codebar:
        return QRFormat.Codabar;
      default:
        return null;
    }
  }
}
