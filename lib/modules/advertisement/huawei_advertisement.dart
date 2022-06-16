import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:huawei_ads/hms_ads_lib.dart';
import 'package:snapretouch/common/device_info.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_extension.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_item.dart';
import 'advertisement_base.dart';

class HuaweiAdvertisement extends AdvertisementBase {
  @override
  AdvertisementProvider get adsProvider => AdvertisementProvider.huawei;

  @override
  Widget createAdWidget({required AdvertisementItem adItem, double? width, double? height, Function(dynamic)? onLoadedAd, Function(dynamic error)?  onAdFailedToLoad}) {
    switch (adItem.type) {
      case AdvertisementType.native:
        var nativeAd = _loadNativeAd(adItem, null, onLoadedAd, onAdFailedToLoad, height == null ? NativeAdType.full : height < 100 ? NativeAdType.small: NativeAdType.banner);
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: nativeAd,
        );
      case AdvertisementType.roll:
        return FutureBuilder<InstreamAdView?>(
          future: _loadInstreamAdView(adItem, null, onLoadedAd, onAdFailedToLoad),
          builder: (_, snapshot) => Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: snapshot.data ?? const SizedBox(),
          ));
      default:
        return const SizedBox();
    }
  }

  @override
  void loadAd({required AdvertisementItem adItem, Function(dynamic)? onAd, Function(dynamic)? onLoadedAd, Function(int? error)?  onAdFailedToLoad}) {
    switch (adItem.type) {
      case AdvertisementType.huaweiBanner:
        _loadBannerAd(adItem, onAd, onLoadedAd, onAdFailedToLoad);
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
      case AdvertisementType.roll:
        _loadInstreamAdView(adItem, onAd, onLoadedAd, onAdFailedToLoad);
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
            _loadRewardAd(adItem, (ad) => ad.show());
            break;
          case AdvertisementType.interstitial:
            _loadInterstitialAd(adItem, (ad) => ad.show());
            break;
          case AdvertisementType.splash:
            _loadSplashAd(adItem);
            break;
          case AdvertisementType.banner:
            _loadBannerAd(adItem, (ad) => ad.show());
            break;
          default:
            break;
        }
      },
    );
  }

  NativeAd? _nativeAd;
  NativeAd _loadNativeAd(AdvertisementItem adItem, [Function(NativeAd)? onAd, Function(NativeAd?)? onLoadedAd, Function(int? error)? onAdFailedToLoad, NativeAdType type = NativeAdType.banner]) {
    _nativeAd = NativeAd(
      adSlotId: adItem.id,
      styles: NativeStyles()
        ..setCallToAction(fontSize: 8)
        ..setFlag(fontSize: 10)
        ..setSource(fontSize: 11),
      type: type,
      controller: NativeAdController(
        adConfiguration: NativeAdConfiguration()..choicesPosition = NativeAdChoicesPosition.bottomRight,
        listener: (AdEvent event, {errorCode}) {
        printLog('loadNativeAd $event');
        switch (event) {
          //  case AdEvent.closed:
          //  case AdEvent.leave:
          case AdEvent.failed:
          if(onAdFailedToLoad != null) onAdFailedToLoad(errorCode);
          break;
          //  case AdEvent.clicked:
          //  case AdEvent.impression:
          //  case AdEvent.disliked:
          case AdEvent.loaded:
          case AdEvent.opened:
          break;
          default:
         }
        },
      ),
    );
    if(onLoadedAd != null) onLoadedAd(_nativeAd);
    if (onAd != null) {
      onAd(_nativeAd!);
    }
    return _nativeAd!;
  }

  BannerAd? _bannerAd;
  BannerAd _loadBannerAd(AdvertisementItem adItem, [Function(BannerAd)? onAd, Function(BannerAd?)? onLoadedAd, Function(int? error)?  onAdFailedToLoad]) {
    _bannerAd = BannerAd(
      adSlotId: adItem.id,
      size: BannerAdSize.s468x60,
      adParam: AdParam(),
      bannerRefreshTime: 5000,
      listener: (AdEvent event, {int? errorCode}) {
        printLog('loadBannerAd $event');
        switch (event) {
          //  case AdEvent.closed:
          //  case AdEvent.leave:
          case AdEvent.failed:
          if(onAdFailedToLoad != null) onAdFailedToLoad(errorCode);
          break;
          //  case AdEvent.clicked:
          //  case AdEvent.impression:
          //  case AdEvent.disliked:
          case AdEvent.loaded:
          case AdEvent.opened:
          if(onLoadedAd != null) onLoadedAd(_bannerAd);
          break;
          default:
        }
      },
    )..loadAd();
    if (onAd != null && _bannerAd != null) {
      onAd(_bannerAd!);
    }
    return _bannerAd!;
  }

  RewardAd? _rewardAd;
  RewardAd _loadRewardAd(AdvertisementItem adItem, [Function(RewardAd)? onAd, Function(RewardAd?)? onLoadedAd, Function(int? error)?  onAdFailedToLoad]) {
    _rewardAd = RewardAd(listener: (RewardAdEvent? event, {Reward? reward, int? errorCode}) {
      printLog('loadRewardAd $event');
      switch (event) {
        // case RewardAdEvent.leftApp:
        // case RewardAdEvent.closed:
        case RewardAdEvent.failedToLoad:
        if(onAdFailedToLoad != null) onAdFailedToLoad(errorCode);
        break;
        // case RewardAdEvent.started:
        // case RewardAdEvent.completed:
        // case RewardAdEvent.rewarded:
        case RewardAdEvent.loaded:
        case RewardAdEvent.opened:
        if(onLoadedAd != null) onLoadedAd(_rewardAd);
        break;
        default:
       }
    })..loadAd(
     adSlotId: adItem.id, 
     adParam: AdParam(),
    );

    if (onAd != null) {
      onAd(_rewardAd!);
    }
    return _rewardAd!;
  }

  InterstitialAd? _interstitialAd;
  InterstitialAd _loadInterstitialAd(AdvertisementItem adItem, [Function(InterstitialAd)? onAd, Function(InterstitialAd?)? onLoadedAd, Function(int? error)?  onAdFailedToLoad]) {
    _interstitialAd = InterstitialAd(
      adSlotId: adItem.id, 
      adParam: AdParam(),
      listener: (AdEvent event, {int? errorCode}) {
      printLog('loadInterstitialAd $event');
      switch (event) {
        //  case AdEvent.closed:
        //  case AdEvent.leave:
        case AdEvent.failed:
        if(onAdFailedToLoad != null) onAdFailedToLoad(errorCode);
        break;
        //  case AdEvent.clicked:
        //  case AdEvent.impression:
        //  case AdEvent.disliked:
        case AdEvent.loaded:
        case AdEvent.opened:
        if(onLoadedAd != null) onLoadedAd(_interstitialAd);
        break;
        default:
       }
    })..loadAd();

    if (onAd != null) {
      onAd(_interstitialAd!);
    }
    return _interstitialAd!;
  }

  Future<InstreamAdView?> _loadInstreamAdView(AdvertisementItem adItem, [Function(InstreamAdView)? onAd, Function(InstreamAdView?)? onLoadedAd, Function(int? error)?  onAdFailedToLoad]) async {
    InstreamAdView? ad; 
    InstreamAdViewController controller = InstreamAdViewController(
      onInstreamAdViewCreated: (_) {
        printLog('loadInstreamAdView created');
        // if (onAd != null) {
        //   onAd(ad!);
        // }
      },
      onClick: () { 
        printLog('loadInstreamAdView clicked');
      },
      onSegmentMediaChange: (instreamAd) {
        printLog('loadInstreamAdView $instreamAd');
      },
      onMediaStart: (playTime) { 
        printLog('loadInstreamAdView $playTime');
      },
      onMediaProgress: (per, playTime) { 
        printLog('loadInstreamAdView $per $playTime');
      },
      onMediaStop: (_) {
        printLog('loadInstreamAdView stopped');
      }
    );

    await InstreamAdLoader(
          adId: adItem.id,
          totalDuration: const Duration(minutes: 1),
          maxCount: 8,
          onAdFailed: (int? errorCode) {
            printLog('failed load InstreamAdView errorCode $errorCode');
            if(onAdFailedToLoad != null) onAdFailedToLoad(errorCode);
          },
          onAdLoaded: (instreamAds) async {
            printLog('loaded InstreamAdView');
            ad = InstreamAdView(
              instreamAds: instreamAds,
              controller: controller,
            );
            if(onLoadedAd != null  && ad != null) onLoadedAd(ad);
          },
    ).loadAd(adParam: AdParam());
    await Future.delayed(const Duration(seconds: 1));
    if (onAd != null) {
      onAd(ad!);
    }
    if(ad != null) {
      controller..mute()..play();
    }
    return ad;
  }

  SplashAd? _splashAd;
  SplashAd _loadSplashAd(AdvertisementItem adItem, [Function(SplashAd)? onAd, Function(dynamic)? onLoadedAd, Function(int? error)?  onAdFailedToLoad]) {
    _splashAd = SplashAd(
      adType: SplashAdType.above,
      ownerText: 'CUSTOM OWNER',
      loadListener: (SplashAdLoadEvent event, {int? errorCode}) {
        printLog('loadSplashAd $event');
        switch (event) {
          case SplashAdLoadEvent.failedToLoad:
            if(onAdFailedToLoad != null) onAdFailedToLoad(errorCode);
            break;
          // case SplashAdLoadEvent.dismissed:
          // break;
          case  SplashAdLoadEvent.loaded:
            if(onLoadedAd != null) onLoadedAd(_splashAd);
            break;
          default:
        }
      }
    )..loadAd(
      adSlotId: adItem.id, 
      orientation: SplashAdOrientation.portrait,
      adParam: AdParam(),
      topMargin: 50
    );

    if (onAd != null) {
      onAd(_splashAd!);
    }
    return _splashAd!;
  }

  @override
  bool isValid() {
    return DeviceInfo.instance.android != null && (DeviceInfo.instance.android!.manufacturer ?? '').toUpperCase() == 'HUAWEI';
  }
}
