import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_config.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_view.dart';

abstract class BaseAdvertisementService {
  void init(AdvertisementConfig advertisement);

  void handleAd({String? screenName});

  Widget? loadAd({required AdvertisementViewType type, AdSize size = AdSize.banner, Function(dynamic)? onAd});
}
