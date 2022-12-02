part of '../extensions.dart';

extension PackageInfoExtesnion on Configuration {
  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String packageName = packageInfo.packageName;

    Debug.log('APP ID: $packageName');
    Debug.log('APP NAME $appName');
    Debug.log('APP VERSION $version');
    Debug.log('App VERSION CODE $buildNumber');

    return packageInfo;
  }
}

extension NetworkExtension on Configuration {
  bool isNetwork(String url) {
    for (var protocol in appConfig.protocols) {
      if (url.startsWith(protocol)) {
        return true;
      }
    }
    return false;
  }
}
