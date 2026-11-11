import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/premium/premium_service.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/more_apps.dart';

class AdView extends StatelessWidget {
  const AdView({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return PropConsumer<PremiumService, bool>(
      select: (_) => _.isPremium,
      builder: (context, _, __, premium) {
        if (premium) return const SizedBox.shrink();
        if (!Configuration.instance.advertisement.enable) {
          return const SizedBox.shrink();
        }

        final contentMaxWidth = AppDimensions.instance.contentMaxWidth;
        final apps = Configuration.instance.business.moreApps;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.instance.padding,
          ).copyWith(top: AppDimensions.instance.padding),
          child: AdBuilder(
            width: width,
            height: height ??
                contentMaxWidth * 1 / 3 + AppDimensions.instance.padding,
            errorBuilder: apps.isNotEmpty
                ? (_) => Padding(
                      padding: EdgeInsets.only(
                          bottom: AppDimensions.instance.padding),
                      child: MoreApps(
                        apps: apps,
                        height: contentMaxWidth * 1 / 3,
                      ),
                    )
                : null,
            successBuilder: (_, ad) => Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.instance.padding),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.instance.radius),
                ),
                child: AppCard(child: ad),
              ),
            ),
            borderRadius: BorderRadius.zero,
          ),
        );
      },
    );
  }
}
