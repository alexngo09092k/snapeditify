import 'package:flutter/material.dart';
import 'package:fluttering/provider/manager_provider.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/widgets/ad_placeholder.dart';

class AdView extends StatefulWidget {
  const AdView({
    Key? key,
    required this.screenName,
    required this.size,
    this.loadingWidget,
  }) : super(key: key);
  final Size size;
  final Widget? loadingWidget;
  final String screenName;

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
  Widget? ad;

  @override
  void initState() {
    ad = ManagerProvider.of<AwesomeAdvertisement>().getAdWidget(widget.size);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppDimensions.instance.paddingSizeDefault,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.instance.paddingSizeDefault),
        ),
        image: DecorationImage(
          image: Image.asset(AppImages.instance.placeholder).image,
          fit: BoxFit.fill,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.paddingSizeDefault)),
        child: Container(
          width: widget.size.width,
          height: ad != null ? widget.size.height : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppDimensions.instance.paddingSizeDefault,
              ),
            ),
            border: Border.all(
              color: Theme.of(context).secondaryHeaderColor,
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              if (ad != null) ad!,
              if (ad == null)
                widget.loadingWidget ??
                    AdPlaceHolder(
                      width: widget.size.width,
                      height: widget.size.height,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
