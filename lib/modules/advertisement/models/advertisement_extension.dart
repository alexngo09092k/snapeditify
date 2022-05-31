import 'package:flutter/foundation.dart';

enum AdvertisementType {openApp, fluid, banner, reward, native, interstitial }

extension AdvertisementTypeExtension on AdvertisementType {
  String get content => describeEnum(this);
}

enum AdvertisementProvider { google }

extension AdvertisementProviderExtension on AdvertisementProvider {
  String get content => describeEnum(this);
}
