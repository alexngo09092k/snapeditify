import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppInternet {
  String? _lookUpAddress;
  static final AppInternet _instance = AppInternet._internal();
  static AppInternet get instance => _instance;
  
  AppInternet._internal();

  static AppInternet getInstance() => _instance;

  bool hasConnection = true;

  StreamController<bool> connectionChangeController =
      StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize(String lookUpAddress) {
    _lookUpAddress = lookUpAddress;
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    assert(_lookUpAddress != null || _lookUpAddress != '');
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup(_lookUpAddress!);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
