import 'dart:convert';

import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/providers/storage_provider.dart';

abstract class IHistoryProvider extends StorageProvider with Provider {
  List<QR> get scanHistory;

  List<QR> get generateHistory;

  void addQR(QR qr);

  void deleteQR(QR qr);

  bool isExists(QR qr);
}

class HistoryProvider extends IHistoryProvider with ProviderDelegate {
  static final IHistoryProvider _instance = HistoryProvider._internal();
  static IHistoryProvider get instance => _instance;

  factory HistoryProvider() => _instance as HistoryProvider;

  HistoryProvider._internal();


  final List<QR> _generateHistory = [];
  final List<QR> _scanHistory = [];

  @override
  List<QR> get generateHistory => _generateHistory;
  
  @override
  List<QR> get scanHistory => _scanHistory;

  @override
  bool isExists(QR qr) {
    switch (qr.source) {
      case QRSource.isScanned:
        List<QR> list = _scanHistory.where((element) => element.rawData == qr.rawData).toList();
        if(list.isNotEmpty) {
          list.first.lastModified = qr.lastModified;
          syncToStorage(true);
        }
        return list.isNotEmpty;
      case QRSource.isGenerated:
        List<QR> list = _generateHistory.where((element) => element.rawData == qr.rawData).toList();
        if(list.isNotEmpty) {
          list.first.lastModified = qr.lastModified;
          syncToStorage(true);
        }
        return list.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  void addQR(QR qr) {
    if(isExists(qr)) return;
    bool changed = false;
    switch (qr.source) {
      case QRSource.isScanned:
        _scanHistory.add(qr);
        changed = true;
        break;
      case QRSource.isGenerated:
        _generateHistory.add(qr);
        changed = true;
        break;
      default:
        break;
    }
    syncToStorage(changed);
  }

  @override
  void deleteQR(QR qr) {
    bool changed = false;
    switch (qr.source) {
      case QRSource.isScanned:
        _scanHistory.removeWhere((element) => element.rawData == qr.rawData);
        changed = true;
        break;
      case QRSource.isGenerated:
        _generateHistory.removeWhere((element) => element.rawData == qr.rawData);
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
      _scanHistory.addAll(jsonDecode(scanHistoryString).map<QR>((_) => QR.fromJson(_)));
    }

    /// GENERATE HISTORY
    String? generateHistoryString = AsyncStorage.instance.getString(AsyncStorageKey.instance.generateHistory);
    if(generateHistoryString != null) {
      Debug.log("============= GENERATE HISTORY $generateHistoryString ============");
      _generateHistory.addAll(jsonDecode(generateHistoryString).map<QR>((_) => QR.fromJson(_)));
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
