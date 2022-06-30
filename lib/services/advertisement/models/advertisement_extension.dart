import 'package:flutter/foundation.dart';

enum AdvertisementType {openApp, fluid, banner, reward, native, interstitial, splash, huaweiBanner, roll}

extension AdvertisementTypeExtension on AdvertisementType {
  String get content => describeEnum(this);
}

enum AdvertisementProvider {google, huawei}

extension AdvertisementProviderExtension on AdvertisementProvider {
  String get content => describeEnum(this);
}
