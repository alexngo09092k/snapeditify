import 'package:snapretouch/common/app_cache.dart';
import 'package:snapretouch/common/app_internet.dart';
import 'package:snapretouch/common/app_shared.dart';
import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/device_info.dart';
import 'package:snapretouch/env.dart';

closeApp() {
  AppCache.instance.clean();
  AppInternet.instance.dispose();
  AppShared.instance.dispose();
}

openApp() {
  AppShared.instance.initialStore();
  Cofiguration.instance.setDefaultConfig(enviroment);
  DeviceInfo.instance.loadInfomation();
}
