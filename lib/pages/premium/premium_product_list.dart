import 'package:flutter/material.dart';
import 'package:fluttering_iap/fluttering_iap.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/premium/premium_service.dart';

class PremiumProductList extends StatelessWidget {
  const PremiumProductList({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final IAPProduct? selected;
  final ValueChanged<IAPProduct> onSelect;

  @override
  Widget build(BuildContext context) {
    // Rebuild when PremiumService / IAP products change via parent setState.
    final products = PremiumService.instance.availableProducts;

    if (products.isEmpty) {
      return _LoadingProducts(
        onFallbackBuy: () {
          final cfg = PremiumService.instance.products;
          if (cfg.isNotEmpty) onSelect(cfg.first);
        },
      );
    }

    final sorted = List<IAPProduct>.from(products)
      ..sort((a, b) {
        final aYear = a.id.toLowerCase().contains('year') ||
            a.id.toLowerCase().contains('oneyear');
        final bYear = b.id.toLowerCase().contains('year') ||
            b.id.toLowerCase().contains('oneyear');
        if (aYear == bYear) return 0;
        return aYear ? -1 : 1;
      });

    if (selected == null && sorted.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onSelect(sorted.first);
      });
    }

    return Column(
      children: [
        for (int i = 0; i < sorted.length; i++) ...[
          if (i > 0) SizedBox(height: AppDimensions.instance.padding * 0.75),
          _ProductCard(
            product: sorted[i],
            isSelected: selected?.id == sorted[i].id,
            isBestValue: i == 0 && sorted.length > 1,
            onTap: () => onSelect(sorted[i]),
          ),
        ],
      ],
    );
  }
}

class _LoadingProducts extends StatelessWidget {
  const _LoadingProducts({this.onFallbackBuy});
  final VoidCallback? onFallbackBuy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.6),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Loading plans…',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.isSelected,
    required this.isBestValue,
    required this.onTap,
  });

  final IAPProduct product;
  final bool isSelected;
  final bool isBestValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final info = product.info!;
    final owned = product.status;

    final borderColor = isSelected
        ? AppColors.brand
        : (isDark ? Colors.white.withOpacity(0.08) : const Color(0xFFE8EAF0));

    return GestureDetector(
      onTap: owned ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
          color: isSelected
              ? (isDark
                  ? AppColors.brand.withOpacity(0.14)
                  : const Color(0xFFF0EFFF))
              : theme.colorScheme.surface,
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.brand.withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [AppColors.instance.softShadow],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected ? AppColors.instance.gradient : null,
                    color: isSelected ? null : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : theme.colorScheme.outline,
                      width: 1.6,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
                SizedBox(width: AppDimensions.instance.padding * 0.85),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              info.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (owned) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFF10B981).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Owned',
                                style: TextStyle(
                                  color: Color(0xFF059669),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppDimensions.instance.padding * 0.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      info.price,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isSelected
                            ? AppColors.brand
                            : theme.colorScheme.onBackground,
                      ),
                    ),
                    if (isBestValue)
                      Text(
                        'Save ~17%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.accent.withOpacity(0.95),
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (isBestValue)
              Positioned(
                top: -AppDimensions.instance.padding - 10,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: AppColors.instance.heroGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brand.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    'BEST VALUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
