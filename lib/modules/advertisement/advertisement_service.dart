import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/modules/advertisement/advertisement_base.dart';
import 'package:snapedit/modules/advertisement/app_lifecycle/app_lifecycle_handler.dart';
import 'package:snapedit/modules/advertisement/base_advertisement_service.dart';
import 'package:snapedit/modules/advertisement/google_advertisement.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_config.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_extension.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_view.dart';

class AdvertisementService
    implements BaseAdvertisementService, AppLifeCycleHandler {
  AdvertisementConfig? adConfig;

  final _listAdView = <AdvertisementView>[];
  final _widgetAds = <Widget>[];
  final _appOpenAds = [];
  final _handleAds = [];

  bool _enableAd = false;

  static final _adsProviders = {
    AdvertisementProvider.google: GoogleAdvertisement(),
  };

  AdvertisementBase? getAdsProvider(AdvertisementProvider? adsProvider) =>
      _adsProviders[adsProvider!];

  @override
  void init(AdvertisementConfig advertisement) {
    adConfig = advertisement;
    if (advertisement.enable && !kIsWeb) {
      _enableAd = true;
      final ads = advertisement.ads;
      for (final ad in ads) {
        final id = ad.id;
        if (id.isEmpty) continue;
        final adView = AdvertisementView(
          data: ad,
        );
        _listAdView.add(adView);
      }
      printLog('[AppState] Init Google Mobile Ads');
      MobileAds.instance.initialize().then((InitializationStatus status) {
        printLog('Initialization done: ${status.adapterStatuses}');

        MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          testDeviceIds: advertisement.googleTestingId,
        ));
      });
    }
  }

  @override
  void handleAd({String? screenName}) async {
    for (final adView in _listAdView) {
      final ad = adView.data;
      if (ad == null) {
        continue;
      }

      final adsProvider = getAdsProvider(ad.provider);
      // Handle show ads
      if (adsProvider == null || ad.showOnScreens.isEmpty) continue;

      // if (ad.showOnScreens.contains(screenName)) {
      if (!adView.active) {
        adView.active = true;
        final ad = adView.data!;
        switch (adView.type) {
          case AdvertisementViewType.widget:
            _widgetAds.add(adsProvider.createAdWidget(adItem: ad));
            break;
          case AdvertisementViewType.openApp:
            adsProvider.loadAd(
                adItem: ad,
                onAd: (appOpenAd) {
                  _appOpenAds.add(appOpenAd);
                });
            break;
          case AdvertisementViewType.handle:
            adsProvider.showAd(adItem: ad);
            break;
          case AdvertisementViewType.none:
            break;
        }
      }
      // }

      // Handle hide ads
      if (ad.hideOnScreens.contains(screenName) ||
          (ad.showOnScreens.isNotEmpty &&
              !ad.showOnScreens.contains(screenName))) {
        EasyDebounce.cancel(ad.id);
        if (adView.active) {
          adView.active = false;
          switch (adView.type) {
            case AdvertisementViewType.widget:
              _widgetAds
                  .removeWhere((element) => element.key == ValueKey(ad.id));
              break;
            case AdvertisementViewType.openApp:
              break;
            case AdvertisementViewType.handle:
              adsProvider.hideAd(ad.id);
              break;
            default:
              break;
          }
        }
      }
    }
  }

  @override
  void onBackground() {}

  @override
  void onForeground() {
    if (_appOpenAds.isNotEmpty) {
      AppOpenAd appOpenAd = _appOpenAds.first;
      appOpenAd.show();
      _appOpenAds.removeAt(0);
    }
  }
}
