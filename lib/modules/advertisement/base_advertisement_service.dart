import 'package:flutter/material.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_config.dart';
class BaseAdvertisementService {
  /// get ad widget
  Widget getAdWidget() => const SizedBox();

  /// init empty Ads
  void init(AdvertisementConfig advertisement) {}

  void handleAd(String? screenName) {}
}
