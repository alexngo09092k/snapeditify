import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/services/services.dart';

class AdView extends StatefulWidget {
  const AdView(
      {Key? key,
      required this.type,
      this.width,
      this.height,
      this.adSize = AdSize.banner,
      this.loadingImage})
      : super(key: key);
  final AdvertisementViewType type;
  final double? width;
  final double? height;
  final AdSize adSize;
  final ImageProvider? loadingImage;

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
  Widget? ad;

  @override
  void initState() {
    Services().advertisement.loadAd(
        type: widget.type,
        size: widget.adSize,
        onAd: (adLoaded) {
          setState(() {
            ad = adLoaded;
          });
        });
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
          decoration: const BoxDecoration(
            color: AppColors.kTeal50,
            // border: Border.all(color: AppColors.topicColor.withOpacity(0.2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.paddingSizeDefault)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(AppDimensions.paddingSizeDefault)),
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: AppColors.kTeal50,
                // image: DecorationImage(
                //   image: widget.loadingImage ?? Image.asset(AppImages.adPlaceholder).image,
                //   fit: BoxFit.fill,
                // ),
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
              child: ad,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
