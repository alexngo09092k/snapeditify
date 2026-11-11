import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';

class PremiumDescription extends StatelessWidget {
  const PremiumDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final features = [
      _Feature(
        icon: Icons.block_rounded,
        color: const Color(0xFFEF4444),
        title: s.noAdsBestExperience,
      ),
      _Feature(
        icon: Icons.auto_awesome_rounded,
        color: AppColors.brand,
        title: s.unlimitedAccessAiFeatures,
      ),
      _Feature(
        icon: Icons.high_quality_rounded,
        color: const Color(0xFF06B6D4),
        title: s.bestOutputImageQuality,
      ),
      _Feature(
        icon: Icons.bolt_rounded,
        color: const Color(0xFFF59E0B),
        title: 'Faster processing & priority queue',
      ),
    ];

    return Container(
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.04)
            : Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : const Color(0xFFE8EAF0),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < features.length; i++) ...[
            if (i > 0) SizedBox(height: AppDimensions.instance.padding * 0.85),
            _FeatureRow(feature: features[i]),
          ],
        ],
      ),
    );
  }
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.color,
    required this.title,
  });
  final IconData icon;
  final Color color;
  final String title;
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature});
  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: feature.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(feature.icon, color: feature.color, size: 20),
        ),
        SizedBox(width: AppDimensions.instance.padding * 0.85),
        Expanded(
          child: Text(
            feature.title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
        Icon(
          Icons.check_circle_rounded,
          size: 20,
          color: AppColors.brand.withOpacity(0.85),
        ),
      ],
    );
  }
}
