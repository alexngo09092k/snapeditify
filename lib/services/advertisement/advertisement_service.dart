import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/services/advertisement/advertisement_base.dart';
import 'package:snapretouch/services/advertisement/app_lifecycle/app_lifecycle_handler.dart';
import 'package:snapretouch/services/advertisement/base_advertisement_service.dart';
import 'package:snapretouch/services/advertisement/google_advertisement.dart';
import 'package:snapretouch/services/advertisement/huawei_advertisement.dart';
import 'package:snapretouch/services/advertisement/models/advertisement_config.dart';
import 'package:snapretouch/services/advertisement/models/advertisement_extension.dart';
import 'package:snapretouch/services/advertisement/models/advertisement_view.dart';

class AdvertisementService implements BaseAdvertisementService, AppLifeCycleHandler {
  AdvertisementConfig? adConfig;

  final Map<AdvertisementViewType, List<AdvertisementView>> _listAdView = {
    AdvertisementViewType.widget: [],
    AdvertisementViewType.openApp: [],
    AdvertisementViewType.splash: [],
    AdvertisementViewType.handle: [],
  };

  final _widgetAds = [];
  final _appOpenAds = [];

  bool _enableAd = false;

  static final _adsProviders = {
    AdvertisementProvider.google: GoogleAdvertisement(),
    AdvertisementProvider.huawei: HuaweiAdvertisement(),
  };

  bool get isHuawei => _adsProviders[AdvertisementProvider.huawei] != null && _adsProviders[AdvertisementProvider.huawei]!.isValid();

  AdvertisementBase? getAdsProvider(AdvertisementProvider? adsProvider) => _adsProviders[adsProvider!];

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
        if (adsProvider == null || ad.showOnScreens.isEmpty || !adsProvider.isValid()) continue;
        _widgetAds.add(adsProvider.createAdWidget(adItem: ad));

        if (ad.hideOnScreens.contains(screenName) || (ad.showOnScreens.isNotEmpty && !ad.showOnScreens.contains(screenName))) {
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

        if (ad.hideOnScreens.contains(screenName) || (ad.showOnScreens.isNotEmpty && !ad.showOnScreens.contains(screenName))) {
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
    if (_listAdView[AdvertisementViewType.openApp] != null && _appOpenAds.isEmpty) {
      for (final adView in _listAdView[AdvertisementViewType.openApp]!) {
        if (adView.data == null) {
          continue;
        }
        final adsProvider = getAdsProvider(adView.data!.provider);
        if (adsProvider == null || !adsProvider.isValid()) continue;
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
    bool loaded = false;
    ///IF OS IS HUAWEI
    if(isHuawei) {
      /// CHECKING SPLASH ADS EXISTS
      if(_listAdView[AdvertisementViewType.splash] != null && _listAdView[AdvertisementViewType.splash]!.isNotEmpty) {
        AdvertisementView adView = (_listAdView[AdvertisementViewType.splash]!).first;
        final adsProvider = getAdsProvider(adView.data!.provider);
        if (adsProvider != null && adsProvider.isValid()) {
          /// SHOW SPLASH ADS
          adsProvider.loadAd(
            adItem: adView.data!,
            onAd: (appOpenAd) {
              _appOpenAds.add(appOpenAd);
            },
          );
          loaded = true;
        }
      }
    }
    ///IF NOT LOADED ADS AND NOT HUAWEI OS
    if (!loaded && _appOpenAds.isNotEmpty) {
      AppOpenAd appOpenAd = _appOpenAds.first;
      appOpenAd.show();
      _appOpenAds.removeAt(0);
    }
  }

  @override
  Widget? loadAd({required AdvertisementViewType type, double? width, double? height, Function(dynamic)? onAd, Function(dynamic)? onLoadedAd, Function(dynamic error)?  onAdFailedToLoad, AdvertisementProvider? provider, String? screenName, AdvertisementType? adType}) {
    if (_listAdView[type] != null && _listAdView[type]!.isNotEmpty) {
      printLog('Starting load ad view type: $type, ad type: $adType, provider $provider');
      // check if exist ad of provider
      AdvertisementView? viewAd;
      ///CHECK HAS PROVIDER AND HAS ADS OF PROVIDER
      if(provider != null) {
        printLog('checking provider');
        bool hasAdOfProvider = _listAdView[type]!.any((adView) => adView.data!.provider == provider && (adType == null ? true : adView.data!.type == adType));
        if(hasAdOfProvider) {
          viewAd = _listAdView[type]!.firstWhere((adView) => adView.data!.provider == provider && (adType == null ? true : adView.data!.type == adType));
        }
      }else {
        /// CHECK PHONE IS HUAWEI AND HAS ADS CONFIG FOR HUAWEI
        bool hasAdOfHuawei = _listAdView[type]!.any((adView) => adView.data!.provider == AdvertisementProvider.huawei && (adType == null ? true : adView.data!.type == adType));

        printLog('has huawei ads');

        if(isHuawei && hasAdOfHuawei) {
          viewAd = _listAdView[type]!.firstWhere((adView) => adView.data!.provider == AdvertisementProvider.huawei && (adType == null ? true : adView.data!.type == adType));
        }else {
          /// IF NOT HUAWEI, GET FIRST AD TO SHOW
          viewAd = _listAdView[type]!.first;
        }
      }
      /// SHOW ADS
      if(viewAd != null) {
        final adsProvider = getAdsProvider(viewAd.data!.provider);
        if(adsProvider!.isValid()) {
          printLog('start loading ads ${viewAd.data!.type} for $screenName ${viewAd.data!.showOnScreens.contains(screenName)}');
          if ((screenName != null && viewAd.data!.showOnScreens.contains(screenName))) {
            if (viewAd.type == AdvertisementViewType.widget) {
              printLog('Progessing load ad view type: ${viewAd.type}, ad type: ${viewAd.data!.type}, provider ${viewAd.data!.provider}');
              Widget? widgetAd = adsProvider.createAdWidget(adItem: viewAd.data!, width:width, height: height,  onLoadedAd: onLoadedAd, onAdFailedToLoad: onAdFailedToLoad);
              if(onAd != null) onAd(widgetAd);
              return widgetAd;
            } else {
              adsProvider.loadAd(adItem: viewAd.data!, onAd: onAd);
            }
          }
        }
        
      }
    }
    return null;
  }
}
