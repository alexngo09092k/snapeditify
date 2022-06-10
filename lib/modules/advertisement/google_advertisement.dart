import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_extension.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_item.dart';
import 'advertisement_base.dart';

class GoogleAdvertisement extends AdvertisementBase {
  @override
  AdvertisementProvider get adsProvider => AdvertisementProvider.google;

  @override
  Widget createAdWidget({required AdvertisementItem adItem, AdSize size = AdSize.banner, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad}) {
    switch (adItem.type) {
      case AdvertisementType.banner:
        var bannerAd = _loadBannerAd(adItem, null, onLoadedAd, onAdFailedToLoad);
        return Container(
          alignment: Alignment.center,
          width: bannerAd.size.width.toDouble(),
          height: bannerAd.size.height.toDouble(),
          child: AdWidget(ad: bannerAd),
        );
      case AdvertisementType.fluid:
        var bannerAd = _loadFluidAd(adItem, null, onLoadedAd, onAdFailedToLoad);
        return Container(
          alignment: Alignment.center,
          child: AdWidget(ad: bannerAd),
        );
      case AdvertisementType.native:
        var nativeAd = _loadNativeAd(adItem, null, onLoadedAd, onAdFailedToLoad);
        return Container(
          alignment: Alignment.center,
          child: AdWidget(ad: nativeAd),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  void loadAd({required AdvertisementItem adItem, Function(dynamic)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad}) {
    switch (adItem.type) {
      case AdvertisementType.banner:
        _loadBannerAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
        break;
      case AdvertisementType.fluid:
        _loadFluidAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
        break;
      case AdvertisementType.native:
        _loadNativeAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
        break;
      case AdvertisementType.reward:
        _loadRewardAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
        break;
      case AdvertisementType.interstitial:
        _loadInterstitialAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
        break;
      case AdvertisementType.openApp:
        _loadOpenAppAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
        break;
      default:
        break;
    }
  }

  @override
  showAd({required AdvertisementItem adItem}) {
    EasyDebounce.debounce(
      adItem.id,
      Duration(seconds: adItem.waitingTimeToDisplay),
      () async {
        switch (adItem.type) {
          case AdvertisementType.reward:
            _loadRewardAd(
                adItem, (ad) => ad.show(onUserEarnedReward: (_, __) {}));
            break;
          case AdvertisementType.interstitial:
            _loadInterstitialAd(adItem, (ad) => ad.show());
            break;
          case AdvertisementType.openApp:
            _loadOpenAppAd(adItem, (ad) => ad.show());
            break;
          default:
            break;
        }
      },
    );
  }

  FluidAdManagerBannerAd _loadFluidAd(AdvertisementItem adItem, [Function(FluidAdManagerBannerAd)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad]) {
    var ad = FluidAdManagerBannerAd(
      adUnitId: adItem.id,
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) {
          printLog('$ad loaded: ${ad.responseInfo}');
          if(onLoadedAd != null) onLoadedAd(ad);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          printLog('Fuild Ad failedToLoad: $error');
          if(onAdFailedToLoad != null) onAdFailedToLoad(error);
          ad.dispose();
        },
        onAdOpened: (Ad ad) => printLog('onAdOpened.'),
        onAdClosed: (Ad ad) => printLog('onAdClosed.'),
      ),
    )..load();
    if (onAd != null) {
      onAd(ad);
    }
    return ad;
  }

  NativeAd _loadNativeAd(AdvertisementItem adItem, [Function(NativeAd)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad]) {
    var ad = NativeAd(
      adUnitId: adItem.id,
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          printLog('$ad loaded: ${ad.responseInfo}');
          if(onLoadedAd != null) onLoadedAd(ad);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          printLog('Native failedToLoad: $error');
          if(onAdFailedToLoad != null) onAdFailedToLoad(error);
          ad.dispose();
        },
      ),
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
    )..load();
    if (onAd != null) {
      onAd(ad);
    }
    return ad;
  }

  BannerAd _loadBannerAd(AdvertisementItem adItem, [Function(BannerAd)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad]) {
    var ad = BannerAd(
      adUnitId: adItem.id,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          printLog('$ad loaded: ${ad.responseInfo}');
          if(onLoadedAd != null) onLoadedAd(ad);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          printLog('Banner failedToLoad: $error');
          if(onAdFailedToLoad != null) onAdFailedToLoad(error);
          ad.dispose();
        },
      ),
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
    )..load();
    if (onAd != null) {
      onAd(ad);
    }
    return ad;
  }

  void _loadRewardAd(AdvertisementItem adItem, [Function(RewardedAd)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad]) {
    RewardedAd.load(
      adUnitId: adItem.id,
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          printLog('$ad loaded.');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) =>
                printLog('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              printLog('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              printLog('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (RewardedAd ad) =>
                printLog('$ad impression occurred.'),
          );
          if(onLoadedAd != null) onLoadedAd(ad);
          if (onAd != null) onAd(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          printLog('RewardedAd failed to load: $error');
          if(onAdFailedToLoad != null) onAdFailedToLoad(error);
        },
      ),
    );
  }

  void _loadInterstitialAd(AdvertisementItem adItem, [Function(InterstitialAd)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad]) {
    InterstitialAd.load(
      adUnitId: adItem.id,
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) =>
                printLog('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              printLog('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              printLog('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) =>
                printLog('$ad impression occurred.'),
          );
          if(onLoadedAd != null) onLoadedAd(ad);
          if (onAd != null) onAd(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          printLog('InterstitialAd failed to load: $error');
          if(onAdFailedToLoad != null) onAdFailedToLoad(error);
        },
      ),
    );
  }

  _loadOpenAppAd(AdvertisementItem adItem, [Function(AppOpenAd)? onAd, Function(Ad)? onLoadedAd, Function(LoadAdError error)?  onAdFailedToLoad]) {
    AppOpenAd.load(
      adUnitId: adItem.id,
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          printLog('app open add loaded');
          // Keep a reference to the ad so you can show it later.
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (AppOpenAd ad) =>
                printLog('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (AppOpenAd ad) {
              printLog('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (AppOpenAd ad, AdError error) {
              printLog('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (AppOpenAd ad) =>
                printLog('$ad impression occurred.'),
          );
          if(onLoadedAd != null) onLoadedAd(ad);
          if (onAd != null) {
            onAd(ad);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          printLog('OpenAppAd failed to load: $error');
          if(onAdFailedToLoad != null) onAdFailedToLoad(error);
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }
}
