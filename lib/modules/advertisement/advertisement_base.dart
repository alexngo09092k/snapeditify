import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_extension.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_item.dart';

abstract class AdvertisementBase {
  AdvertisementProvider get adsProvider;

  void showAd({required AdvertisementItem adItem});

  void hideAd(String adId) {
    EasyDebounce.cancel(adId);
  }

  void loadAd({required AdvertisementItem adItem, Function(dynamic)? onAd});

  Widget createAdWidget({required AdvertisementItem adItem, AdSize size = AdSize.banner});
}
