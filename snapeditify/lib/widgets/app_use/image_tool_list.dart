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
    showDialog(
      context: context,
      builder: (_) => MoreToolsPopup(onTool: onTool),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contentMaxWidth = AppDimensions.instance.contentMaxWidth;
    final itemWidth = contentMaxWidth / 4 -
        AppDimensions.instance.gridDelegate.mainAxisSpacing * 2;
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
              ImageTool.restoreOldPhoto,
              ImageTool.applyArtEffect,
              ImageTool.createAnimeAI,
              ImageTool.changeBackground,
              ImageTool.changeYourSky,
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
                      CustomIcon(e.icon, size: AppDimensions.instance.icon),
                      SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                      Text(e.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge)
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
                    CustomIcon(AppAssets.instance.icAI,
                        size: AppDimensions.instance.icon),
                    SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                    Text("More Tools",
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
