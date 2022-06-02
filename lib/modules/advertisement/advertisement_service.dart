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

class AdvertisementService implements BaseAdvertisementService, AppLifeCycleHandler {
  AdvertisementConfig? adConfig;

  final Map<AdvertisementViewType, List<AdvertisementView>> _listAdView = {
    AdvertisementViewType.widget: [],
    AdvertisementViewType.openApp: [],
    AdvertisementViewType.handle: [],
  };

  final _widgetAds = [];
  final _appOpenAds = [];

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
        if (_listAdView[adView.type] != null) {
          _listAdView[adView.type]!.add(adView);
        }
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
    if (!_enableAd) return;
    if (_listAdView[AdvertisementViewType.widget] != null) {
      for (final adView in _listAdView[AdvertisementViewType.widget]!) {
        final ad = adView.data;
        if (ad == null) {
          continue;
        }

        final adsProvider = getAdsProvider(ad.provider);
        if (adsProvider == null || ad.showOnScreens.isEmpty) continue;

        _widgetAds.add(adsProvider.createAdWidget(adItem: ad));
        if (ad.hideOnScreens.contains(screenName) ||
            (ad.showOnScreens.isNotEmpty &&
                !ad.showOnScreens.contains(screenName))) {
          EasyDebounce.cancel(ad.id);
          if (adView.active) {
            adView.active = false;
            _widgetAds.removeWhere((element) => element.key == ValueKey(ad.id));
          }
        }
      }
    }

    if (_listAdView[AdvertisementViewType.handle] != null) {
      for (final adView in _listAdView[AdvertisementViewType.handle]!) {
        final ad = adView.data;
        if (ad == null) {
          continue;
        }

        final adsProvider = getAdsProvider(ad.provider);
        if (adsProvider == null || ad.showOnScreens.isEmpty) continue;

        adsProvider.showAd(adItem: ad);

        if (ad.hideOnScreens.contains(screenName) ||
            (ad.showOnScreens.isNotEmpty &&
                !ad.showOnScreens.contains(screenName))) {
          EasyDebounce.cancel(ad.id);
          if (adView.active) {
            adView.active = false;
            adsProvider.hideAd(ad.id);
          }
        }
      }
    }
  }

  @override
  void onBackground() {
    if (!_enableAd) return;
    if (_listAdView[AdvertisementViewType.openApp] != null) {
      for (final adView in _listAdView[AdvertisementViewType.openApp]!) {
        if (adView.data == null) {
          continue;
        }
        final adsProvider = getAdsProvider(adView.data!.provider);
        if (adsProvider == null) continue;
        adsProvider.loadAd(
          adItem: adView.data!,
          onAd: (appOpenAd) {
            _appOpenAds.add(appOpenAd);
          },
        );
      }
    }
  }

  @override
  void onForeground() {
    if (!_enableAd) return;
    if (_appOpenAds.isNotEmpty) {
      AppOpenAd appOpenAd = _appOpenAds.first;
      appOpenAd.show();
      _appOpenAds.removeAt(0);
    }
  }

  @override
  Widget? loadAd({required AdvertisementViewType type, AdSize size = AdSize.banner, Function(dynamic)? onAd}) {
    if (_listAdView[type] != null && _listAdView[type]!.isNotEmpty) {
      final viewAd = _listAdView[type]!.first;
      final adsProvider = getAdsProvider(viewAd.data!.provider);
      if (adsProvider != null) {
        if (viewAd.type == AdvertisementViewType.widget) {
          Widget? widgetAd = adsProvider.createAdWidget(adItem: viewAd.data!, size: size);
          if(onAd != null) onAd(widgetAd);
        } else {
          adsProvider.loadAd(adItem: viewAd.data!, onAd: onAd);
        }
      }
    }
    return null;
  }
}
