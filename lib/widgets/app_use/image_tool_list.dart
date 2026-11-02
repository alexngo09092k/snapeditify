import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/app_use/more_tools_popup.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class ImageToolList extends StatelessWidget {
  const ImageToolList({super.key, required this.onTool, this.currentTool});
  final ImageTool? currentTool;
  final Function(ImageTool) onTool;

  void showMoreTools() async {
    return WidgetUtils.instance.showDialog(
      builder: (_) => MoreToolsPopup(onTool: (_) {
        WidgetUtils.instance.dismiss();
        onTool(_);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tools = <ImageTool>[
      ImageTool.removeObject,
      ImageTool.enhanceImage,
      ImageTool.applyArtEffect,
    ].where((item) => item != currentTool).toList();

    return Row(
      children: [
        for (final e in tools)
          Expanded(
            child: _QuickTool(
              image: e.icon,
              label: e.shortTitle(context),
              onTap: () => onTool(e),
            ),
          ),
        Expanded(
          child: _QuickTool(
            image: null,
            materialIcon: Icons.grid_view_rounded,
            label: S.of(context).seeAll,
            onTap: showMoreTools,
            accent: true,
          ),
        ),
      ],
    );
  }
}

class _QuickTool extends StatelessWidget {
  const _QuickTool({
    required this.label,
    required this.onTap,
    this.image,
    this.materialIcon,
    this.accent = false,
  });

  final String? image;
  final IconData? materialIcon;
  final String label;
  final VoidCallback onTap;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color iconColor = accent ? Colors.white : cs.primary;
    final Color labelColor =
        accent ? cs.primary : cs.onSurface.withOpacity(isDark ? 0.92 : 0.88);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: cs.primary.withOpacity(0.12),
        highlightColor: cs.primary.withOpacity(0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: accent
                      ? AppColors.instance.gradient
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [
                                  cs.primary.withOpacity(0.28),
                                  cs.secondary.withOpacity(0.16),
                                ]
                              : [
                                  cs.primary.withOpacity(0.14),
                                  cs.secondary.withOpacity(0.08),
                                ],
                        ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: accent
                        ? Colors.white.withOpacity(0.15)
                        : cs.primary.withOpacity(isDark ? 0.35 : 0.18),
                  ),
                  boxShadow: accent
                      ? [
                          BoxShadow(
                            color: cs.primary.withOpacity(0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                alignment: Alignment.center,
                child: materialIcon != null
                    ? Icon(materialIcon, size: 24, color: iconColor)
                    : CustomImage(
                        image: image!,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        color: iconColor,
                      ),
              ),
              const SizedBox(height: 7),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: labelColor,
                      letterSpacing: 0.1,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
