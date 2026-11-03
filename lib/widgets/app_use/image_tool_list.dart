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
            materialIcon: Icons.apps_rounded,
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
    final Color labelColor = accent
        ? cs.primary
        : cs.onSurface.withOpacity(isDark ? 0.9 : 0.78);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: cs.primary.withOpacity(0.1),
        highlightColor: cs.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: accent
                      ? AppColors.instance.gradient
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? [
                                  cs.primary.withOpacity(0.22),
                                  cs.secondary.withOpacity(0.12),
                                ]
                              : [
                                  const Color(0xFFF0F0FF),
                                  const Color(0xFFE8FBFF),
                                ],
                        ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: accent
                        ? Colors.white.withOpacity(0.2)
                        : (isDark
                            ? cs.primary.withOpacity(0.25)
                            : const Color(0xFFE4E7F5)),
                    width: 1,
                  ),
                  boxShadow: accent
                      ? [
                          BoxShadow(
                            color: cs.primary.withOpacity(0.28),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
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
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: labelColor,
                      letterSpacing: 0.15,
                      fontSize: 11.5,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
