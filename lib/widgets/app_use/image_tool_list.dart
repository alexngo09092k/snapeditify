import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/app_use/more_tools_popup.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class ImageToolList extends StatelessWidget {
  const ImageToolList({super.key, required this.onTool});
  final Function(ImageTool) onTool;

  void showMoreTools(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) => MoreToolsPopup(onTool: (_) {
        Navigator.of(context).pop();
        onTool(_);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contentMaxWidth = AppDimensions.instance.contentMaxWidth;
    final itemWidth = contentMaxWidth / 4 - AppDimensions.instance.gridDelegate.mainAxisSpacing * 2;
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.instance.paddingX(0.5)),
      child: Wrap(
          alignment: WrapAlignment.center,
          spacing: AppDimensions.instance.gridDelegate.mainAxisSpacing,
          runSpacing: AppDimensions.instance.gridDelegate.crossAxisSpacing,
          children: [
            ...[
              ImageTool.removeObject,
              ImageTool.enhanceImage,
              ImageTool.generateAnimeAI,
            ].map((e) {
              return GestureDetector(
                onTap: () => onTool(e),
                child: AppCard(
                  margin: EdgeInsets.all(AppDimensions.instance.paddingX(0.25)),
                  width: itemWidth,
                  height: itemWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomIcon(
                        e.icon,
                        size: AppDimensions.instance.icon,
                      ),
                      SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                      Text(
                        e.shortTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
            GestureDetector(
              onTap: () => showMoreTools(context),
              child: AppCard(
                margin: EdgeInsets.all(AppDimensions.instance.paddingX(0.25)),
                width: itemWidth,
                height: itemWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomIcon(
                      Icons.meno,
                      size: AppDimensions.instance.icon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
