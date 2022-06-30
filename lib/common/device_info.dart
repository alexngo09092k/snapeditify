import 'package:device_info_plus/device_info_plus.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';

class DeviceInfo {
  static final DeviceInfo _instance = DeviceInfo._internal();
  static DeviceInfo get instance => _instance;

  factory DeviceInfo() => _instance;

  DeviceInfo._internal() {
    deviceInfoPlugin = DeviceInfoPlugin();
  }

  late final DeviceInfoPlugin deviceInfoPlugin;

  IosDeviceInfo? ios;
  AndroidDeviceInfo? android;
  WebBrowserInfo? web;
  Map<String, dynamic>? info;

  Future<void> initial() async {
    if (isIos) {
      ios = await deviceInfoPlugin.iosInfo;
      printLog('device info ios $ios');
    }
    if (isAndroid) {
      android = await deviceInfoPlugin.androidInfo;
      printLog('device info android $android');
    }
    if (kIsWeb){
       web = await deviceInfoPlugin.webBrowserInfo;
       printLog('device info web $web');
    }
    info = (await deviceInfoPlugin.deviceInfo).toMap();
  }
}