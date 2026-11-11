import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/premium/premium_service.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/utils/ad_revenue_manager.dart';
import 'package:snapeditify/widgets/base/app_card.dart';

class UnlockPremium extends StatelessWidget {
  const UnlockPremium({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Configuration.instance.iap.enable) return const SizedBox.shrink();

    return PropConsumer<PremiumService, bool>(
      select: (_) => _.isPremium,
      builder: (context, _, __, premium) {
        if (premium) {
          return Padding(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: AppCard(
              padding: EdgeInsets.all(AppDimensions.instance.padding),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppColors.instance.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: AppDimensions.instance.padding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Active',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: AppDimensions.instance.paddingX(0.25)),
                        Text(
                          'Ads removed · Full AI access',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(top: AppDimensions.instance.padding),
          child: GestureDetector(
            onTap: () {
              AdRevenueManager.instance.onNavigation(placement: 'premium');
              AppRoutes.instance.goPremiumProPage(context);
            },
            child: AppCard(
              margin: EdgeInsets.symmetric(
                horizontal: AppDimensions.instance.padding,
              ).copyWith(bottom: AppDimensions.instance.padding),
              child: Container(
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.instance.radius),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.brand.withOpacity(0.12),
                      AppColors.accent.withOpacity(0.10),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.instance.heroGradient,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brand.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    SizedBox(width: AppDimensions.instance.padding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).unlockSnapeditifyPremium,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                              height: AppDimensions.instance.paddingX(0.35)),
                          Text(
                            S.of(context).noAdsBestImageQuality,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.45),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
