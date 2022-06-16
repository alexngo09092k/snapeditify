import 'package:flutter/material.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_config.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';

abstract class BaseAdvertisementService {
  void init(AdvertisementConfig advertisement);

  void handleAd({String? screenName});

  Widget? loadAd({required AdvertisementViewType type, double? width, double? height, Function(dynamic)? onAd});
}
