import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_view.dart';
import 'package:snapedit/services/services.dart';

class AdView extends StatefulWidget {
  const AdView({Key? key, required this.type, this.width, this.height, this.adSize = AdSize.banner}): super(key: key);
  final AdvertisementViewType type;
  final double? width;
  final double? height;
  final AdSize adSize;

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
  Widget? ad;

  @override
  void initState() {
    Services().advertisement.loadAd(type: widget.type, size: widget.adSize, onAd: (adLoaded) {
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
        return ad != null ? ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(AppDimensions.paddingSizeDefault)),
          child: Container(
            margin: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.all(Radius.circular(AppDimensions.paddingSizeDefault)),
              border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: 1)
            ),
            child: ad,
          ),
        ): const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
