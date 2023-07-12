import 'dart:convert';

import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_data.dart';
import 'package:qr_scanner/models/qr_data_type.dart';
import 'package:qr_scanner/providers/storage_provider.dart';

abstract class IHistoryProvider extends StorageProvider with Provider {
  List<QRData> get scanHistory;

  List<QRData> get generateHistory;

  void addQRData(QRData qrData);

  bool isExists(QRDataType type, String qrData);
}

class HistoryProvider extends IHistoryProvider with ProviderDelegate {
  static final IHistoryProvider _instance = HistoryProvider._internal();
  static IHistoryProvider get instance => _instance;

  factory HistoryProvider() => _instance as HistoryProvider;

  HistoryProvider._internal();


  final List<QRData> _generateHistory = [];
  final List<QRData> _scanHistory = [];

  @override
  List<QRData> get generateHistory => _generateHistory;
  
  @override
  List<QRData> get scanHistory => _scanHistory;

  @override
  bool isExists(QRDataType type, String qrData) {
    switch (type) {
      case QRDataType.isScanned:
        List<QRData> list = _scanHistory.where((element) => element.qrData == qrData).toList();
        if(list.isNotEmpty) {
          list.first.lastModified = DateTime.now();
          syncToStorage(true);
        }
        return list.isNotEmpty;
      case QRDataType.isGenerated:
        List<QRData> list = _generateHistory.where((element) => element.qrData == qrData).toList();
        if(list.isNotEmpty) {
          list.first.lastModified = DateTime.now();
          syncToStorage(true);
        }
        return list.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  void addQRData(QRData qrData) {
    if(isExists(qrData.type, qrData.qrData)) return;
    bool changed = false;
    switch (qrData.type) {
      case QRDataType.isScanned:
        _scanHistory.add(qrData);
        changed = true;
        break;
      case QRDataType.isGenerated:
        _generateHistory.add(qrData);
        changed = true;
        break;
      default:
        break;
    }
    syncToStorage(changed);
  }

  @override
  void clean([bool notify = false]) {
    _scanHistory.clear();
    _generateHistory.clear();
    if(notify) notifyListeners();
  }

  @override
  Future<bool> cleanToStorage([bool notify = false]) async {
    clean(notify);

    final result1 = await AsyncStorage.instance.remove(AsyncStorageKey.instance.scanHistory);
    final result2 = await AsyncStorage.instance.remove(AsyncStorageKey.instance.generateHistory);

    return result1 && result2;
  }

  @override
  Future<void> syncFromServer([bool notify = false]) async {}

  @override
  void syncFromStorage([bool notify = false]) {
    /// SCAN HISTORY
    String? scanHistoryString = AsyncStorage.instance.getString(AsyncStorageKey.instance.scanHistory);
    if(scanHistoryString != null) {
      Debug.log("============= SCAN HISTORY $scanHistoryString ============");
      _scanHistory.addAll(jsonDecode(scanHistoryString).map<QRData>((_) => QRData.fromJson(_)));
    }

    /// GENERATE HISTORY
    String? generateHistoryString = AsyncStorage.instance.getString(AsyncStorageKey.instance.generateHistory);
    if(generateHistoryString != null) {
      Debug.log("============= GENERATE HISTORY $generateHistoryString ============");
      _generateHistory.addAll(jsonDecode(generateHistoryString).map<QRData>((_) => QRData.fromJson(_)));
    }
  }

  @override
  Future<void> syncToStorage([bool notify = false]) async {
    AsyncStorage.instance.setString(AsyncStorageKey.instance.scanHistory, jsonEncode(_scanHistory));
    AsyncStorage.instance.setString(AsyncStorageKey.instance.generateHistory, jsonEncode(_generateHistory));
  }

  @override
  Future<bool> registered() {
    syncFromStorage(true);
    return super.registered();
  }
}
