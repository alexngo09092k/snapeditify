import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/services/advertisement/models/advertisement_extension.dart';
import 'package:snapretouch/services/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/services/services.dart';
import 'package:snapretouch/widgets/ad_placeholder.dart';

class AdView extends StatefulWidget {
  const AdView({
    Key? key,
    required this.type,
    required this.screenName,
    this.provider,
    this.width,
    this.height,
    this.loadingWidget,
    this.adType,
  }) : super(key: key);
  final AdvertisementViewType type;
  final double? width;
  final double? height;
  final Widget? loadingWidget;
  final String screenName;
  final AdvertisementProvider? provider;
  final AdvertisementType? adType;

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
  Widget? ad;
  bool isLoaded = false;

  @override
  void initState() {
    Services().advertisement.loadAd(
          screenName: widget.screenName,
          type: widget.type,
          width: widget.width,
          height: widget.height,
          provider: widget.provider,
          adType: widget.adType,
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
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimensions.paddingSizeDefault),
            ),
            image: DecorationImage(
              image: Image.asset(AppImages.placeholder).image,
              fit: BoxFit.fill,
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.paddingSizeDefault)),
            child: Container(
              width: widget.width,
              height: isLoaded ? widget.height : null,
              decoration: BoxDecoration(
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
              child: Stack(
                children: [
                  if ((Services().advertisement.isHuawei || isLoaded) && ad != null) ad!,
                  if (!isLoaded)
                    widget.loadingWidget ??
                        AdPlaceHolder(
                          width: widget.width,
                          height: widget.height,
                        ),
                ],
              ),
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
