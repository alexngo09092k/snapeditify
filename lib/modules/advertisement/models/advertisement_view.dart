import 'package:snapretouch/modules/advertisement/models/advertisement_extension.dart';

import 'advertisement_item.dart';

enum AdvertisementViewType {
  widget,
  handle,
  openApp,
  none,
}

class AdvertisementView {
  bool active;
  AdvertisementItem? data;

  AdvertisementView({
    this.active = false,
    this.data,
  });

  AdvertisementViewType get type {
    if (data == null) return AdvertisementViewType.none;
    switch (data!.type) {
      case AdvertisementType.banner:
      case AdvertisementType.native:
      case AdvertisementType.fluid:
        return AdvertisementViewType.widget;
      case AdvertisementType.interstitial:
      case AdvertisementType.reward:
        return AdvertisementViewType.handle;
      case AdvertisementType.openApp:
        return AdvertisementViewType.openApp;
    }
  }
}
