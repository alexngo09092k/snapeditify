part of '../extensions.dart';

extension NetworkTracking on IClientHttp {
  Future<bool> safeEnvironment() async {
    final bool hasInternet = InternetConnection.instance.hasConnection;
    Debug.log("==========> INTERNET: $hasInternet");

    if (!hasInternet) return false;

    if (Configuration.instance.business.appMode == AppMode.debug) return true;

    final bool vpnActive = await isVpnActive();
    Debug.log("==========> VPN: $vpnActive");

    final bool proxyEnabled = await isProxyEnabled();
    Debug.log("==========> PROXY: $proxyEnabled");

    return !(vpnActive || proxyEnabled);
  }
}
