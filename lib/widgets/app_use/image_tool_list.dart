import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/widgets/app_use/more_tools_popup.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class ImageToolList extends StatelessWidget {
  const ImageToolList({super.key, required this.onTool, this.currentTool});
  final ImageTool? currentTool;
  final Function(ImageTool) onTool;

  void showMoreTools() async {
    return WidgetUtils.instance.showDialog(
      builder: (_) => MoreToolsPopup(onTool: (_) {
        WidgetUtils.instance.dimiss();
        onTool(_);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double contentMaxWidth = AppDimensions.instance.contentMaxWidth;
    double itemWidth = contentMaxWidth / 4 - AppDimensions.instance.gridDelegate.mainAxisSpacing * 2;
    List<ImageTool> tools = [
      ImageTool.removeObject,
      ImageTool.enhanceImage,
      ImageTool.generateAnimeAI
    ];
    tools = tools.where((item) => item != currentTool).toList();
    if (tools.length < 3) tools.add(ImageTool.applyArtEffect);
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.instance.paddingX(0.5)),
      child: Wrap(
          alignment: WrapAlignment.center,
          spacing: AppDimensions.instance.gridDelegate.mainAxisSpacing,
          runSpacing: AppDimensions.instance.gridDelegate.crossAxisSpacing,
          children: [
            ...tools.map((e) {
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
              onTap: showMoreTools,
              child: AppCard(
                margin: EdgeInsets.all(AppDimensions.instance.paddingX(0.25)),
                width: itemWidth,
                height: itemWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomIcon(
                      Icons.widgets_outlined,
                      size: AppDimensions.instance.icon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                    Text(
                      "See All",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
