import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class MoreToolsPopup extends StatelessWidget {
  const MoreToolsPopup({
    super.key,
    required this.onTool,
  });
  final Function(ImageTool) onTool;

  @override
  Widget build(BuildContext context) {
    final spacing = AppDimensions.instance.paddingX(0.5);
    final double itemWidth = (AwesomeAppState.screen.width - spacing * 5) * 1 / 2;
    return AppCard(
      margin: EdgeInsets.only(top: AwesomeAppState.screen.height * 1 / 5),
      color: Theme.of(context).colorScheme.background,
      height: AwesomeAppState.screen.height * 4 / 5,
      child: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          padding: EdgeInsets.symmetric(
            vertical: AppDimensions.instance.paddingX(2),
            horizontal: AppDimensions.instance.padding,
          ),
          childAspectRatio: itemWidth / (itemWidth * 2 / 3),
          children: ImageTool.values
              .map((e) => ImageToolItem(e, onTool: onTool))
              .toList(),
        ),
      ),
    );
  }
}

class ImageToolItem extends StatelessWidget {
  const ImageToolItem(this.imageTool, {super.key, required this.onTool});
  final ImageTool imageTool;
  final Function(ImageTool) onTool;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTool(imageTool),
      child: PropConsumer<IThemeProvider, ThemeMode>(
          select: (_) => _.themeMode,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIcon(
                    imageTool.icon,
                    size: AppDimensions.instance.iconX(1.5),
                  ),
                  SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                  Text(
                    imageTool.title(context),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            ],
          ),
          builder: (_, child, p, themeMode) {
            return Container(
              decoration: BoxDecoration(
                color: themeMode == ThemeMode.light
                    ? imageTool.color
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.instance.radius),
                ),
              ),
              padding: EdgeInsets.all(AppDimensions.instance.padding),
              child: child,
            );
          }),
    );
  }
}
