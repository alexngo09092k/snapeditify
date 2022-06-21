import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapretouch/common/logs.dart';

class AppShared {
  static final AppShared _instance = AppShared._internal();
  static AppShared get instance => _instance;

  factory AppShared() => _instance;

  SharedPreferences? _sharedPreferences;

  late StreamController<AppSharedEvent> _streamController;

  AppShared._internal() {
    _streamController = StreamController<AppSharedEvent>();
    initialStore();
  }

  bool get canStored => _sharedPreferences != null;

  Future<bool> setString(String key, String value) async {
    if (!canStored) return false;
    bool result = await _sharedPreferences!.setString(key, value);
    if (result) _publishEvent(AppSharedEvent<String>(key, value));
    return result;
  }

  String? getString(String key) {
    if (!canStored) return null;
    String? value = _sharedPreferences!.getString(key);
    return value;
  }

  Future<bool> setInt(String key, int value) async {
    if (!canStored) return false;
    bool result = await _sharedPreferences!.setInt(key, value);
    if (result) _publishEvent(AppSharedEvent<int>(key, value));
    return result;
  }

  int? getInt(String key) {
    if (!canStored) return null;
    int? value = _sharedPreferences!.getInt(key);
    return value;
  }

  Future<bool> setBool(String key, bool value) async {
    if (!canStored) return false;
    bool result = await _sharedPreferences!.setBool(key, value);
    if (result) _publishEvent(AppSharedEvent<bool>(key, value));
    return result;
  }

  bool? getBool(String key) {
    if (!canStored) return null;
    bool? value = _sharedPreferences!.getBool(key);
    return value;
  }

  Future<bool> setStringList(String key, List<String> value) async {
    if (!canStored) return false;
    bool result = await _sharedPreferences!.setStringList(key, value);
    if (result) _publishEvent(AppSharedEvent<List<String>>(key, value));
    return result;
  }

  List<String>? getStringList(String key) {
    if (!canStored) return null;
    List<String>? value = _sharedPreferences!.getStringList(key);
    return value;
  }

  Future<bool> setDouble(String key, double value) async {
    if (!canStored) return false;
    bool result = await _sharedPreferences!.setDouble(key, value);
    if (result) _publishEvent(AppSharedEvent<double>(key, value));
    return result;
  }

  double? getDouble(String key) {
    if (!canStored) return null;
    double? value = _sharedPreferences!.getDouble(key);
    return value;
  }

  initialStore() async {
    try {
      _sharedPreferences ??= await SharedPreferences.getInstance();
    } catch (error) {
      printLog(error);
    }
  }

  StreamSubscription addListener(Function(dynamic) listener) {
    return _streamController.stream.listen(listener);
  }

  _publishEvent(AppSharedEvent event) {
    _streamController.sink.add(event);
  }

  dispose() {
    _streamController.close();
  }
}

class AppSharedEvent<T> {
  final String key;
  final T value;

  AppSharedEvent(this.key, this.value);
}
