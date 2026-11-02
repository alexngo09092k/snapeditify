import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/custom_image.dart';

class HomeBaseTools extends StatelessWidget {
  const HomeBaseTools(this.tools, {super.key, required this.title, this.hot = false});
  final List<ImageTool> tools;
  final String title;
  final bool hot;

  void onTool(BuildContext context, ImageTool tool) {
    AppRoutes.instance.goAlbumsPage(context, tool);
  }

  @override
  Widget build(BuildContext context) {
    final screenW = AwesomeAppState.screen.width;
    final pad = AppDimensions.instance.padding;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double cardW;
    if (tools.length <= 2) {
      cardW = (screenW - pad * 2 - 12) / 2;
    } else {
      cardW = (screenW - pad * 2 - 20) / 2.3;
    }
    final cardH = cardW * 1.18;

    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.instance.paddingX(0.95)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pad),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    gradient: AppColors.instance.gradient,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.15,
                        ),
                  ),
                ),
                if (hot)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFF97316)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      S.of(context).hot,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.instance.paddingX(0.75)),
          SizedBox(
            height: cardH,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: pad),
              itemCount: tools.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => HomeBaseTool(
                tools[i],
                width: cardW,
                height: cardH,
                onTool: (_) => onTool(context, _),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeBaseTool extends StatelessWidget {
  const HomeBaseTool(
    this.tool, {
    super.key,
    required this.width,
    required this.height,
    required this.onTool,
  });
  final ImageTool tool;
  final double width;
  final double height;
  final Function(ImageTool) onTool;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onTool(tool),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomImage(image: tool.image, fit: BoxFit.cover),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: height * 0.48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.78),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                tool.shortTitle(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.15,
                      shadows: const [
                        Shadow(color: Colors.black54, blurRadius: 10),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
