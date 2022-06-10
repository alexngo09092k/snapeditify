import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/services/services.dart';

class AdView extends StatefulWidget {
  const AdView(
      {Key? key,
      required this.type,
      this.width,
      this.height,
      this.adSize = AdSize.banner,
      this.loadingWidget,
      })
      : super(key: key);
  final AdvertisementViewType type;
  final double? width;
  final double? height;
  final AdSize adSize;
  final Widget? loadingWidget;

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
  Widget? ad;
  bool isLoaded = false;

  @override
  void initState() {
    Services().advertisement.loadAd(
        type: widget.type,
        size: widget.adSize,
        onAd: (adWidget) => ad = adWidget,
        onLoadedAd: (ad) {
          isLoaded = true;
          printLog('loaded ad from AdView');
          setState(() {});
        },
        onAdFailedToLoad: (error) {
          isLoaded = false;
          printLog('load failed ad from AdView');
          setState(() {});
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case AdvertisementViewType.widget:
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSizeDefault,
          ),
          decoration: BoxDecoration(
            color: AppColors.kTeal50,
            border: Border.all(color: AppColors.topicColor.withOpacity(0.2), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(AppDimensions.paddingSizeDefault)),
            image: DecorationImage(
              image: Image.asset(AppImages.adPlaceholder).image,
              fit: BoxFit.fill,
            )
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(AppDimensions.paddingSizeDefault)),
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: AppColors.kTeal50,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimensions.paddingSizeDefault,
                  ),
                ),
                border: Border.all(
                  color: Theme.of(context).secondaryHeaderColor,
                  width: 1,
                ),
              ),
              child: isLoaded ? ad : widget.loadingWidget,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
