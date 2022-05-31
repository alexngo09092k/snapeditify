
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_extension.dart';

class AdView extends StatelessWidget {
  const AdView({Key? key, required this.type, required this.size}) : super(key: key);
  final AdvertisementType type;
  final AdSize size;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AdvertisementType.banner:
        return Container(
          margin: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
          height: MediaQuery.of(context).size.height * 1 / 4,
          color: AppColors.disable,
          // child:  const Center(
          //   // child: Services().advertisement.getAdWidget(type: type, size: size),
          // ),
        );
      default:
      return const SizedBox();
    }
  }
}
