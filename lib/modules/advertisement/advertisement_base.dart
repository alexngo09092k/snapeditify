import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_extension.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_item.dart';

abstract class AdvertisementBase {
  AdvertisementProvider get adsProvider;

  bool isValid();

  void showAd({required AdvertisementItem adItem});

  void hideAd(String adId) {
    EasyDebounce.cancel(adId);
  }

  void loadAd({required AdvertisementItem adItem, Function(dynamic)? onAd, Function(dynamic ad)? onLoadedAd, Function(dynamic error)?  onAdFailedToLoad});

  Widget? createAdWidget({required AdvertisementItem adItem, double? width, double? height, Function(dynamic)? onLoadedAd, Function(dynamic error)?  onAdFailedToLoad});
}
