import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
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
    double size = AwesomeAppState.screen.width / 3;
    if(tools.length < 3){
      size = (AwesomeAppState.screen.width - AppDimensions.instance.padding * 3) / 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
              if(hot) Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppDimensions.instance.paddingX(0.1),
                  horizontal: AppDimensions.instance.paddingX(0.5),
                ),
                margin: EdgeInsets.only(left: AppDimensions.instance.paddingX(0.5)),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius))
                ),
                child: Text(
                  S.of(context).hot, 
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.instance.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        SizedBox(
          height: size + AppDimensions.instance.paddingX(2),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(bottom: AppDimensions.instance.paddingX(2)).copyWith(
              left: AppDimensions.instance.paddingX(0.5),
              right: AppDimensions.instance.paddingX(0.5),
            ),
            itemBuilder: (_, __) => HomeBaseTool(
              tools[__], 
              size: size, 
              index: __, 
              total: tools.length, 
              onTool: (_) => onTool(context, _),
            ),
            itemCount: tools.length,
          ),
        ),
      ],
    );
  }
}

class HomeBaseTool extends StatelessWidget {
  const HomeBaseTool(this.tool, {super.key, required this.size, required this.index, required this.total, required this.onTool});
  final ImageTool tool;
  final double size;
  final int index;
  final int total;
  final Function(ImageTool) onTool;

  void _onTool() {
    onTool(tool);
  }

  @override
  Widget build(BuildContext context) {
    final margin = EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(0.5));
    return GestureDetector(
      onTap: _onTool,
      child: AppCard(
        width: size,
        height: size,
        margin: margin,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)), 
                child: CustomImage(image: tool.image, fit: BoxFit.cover),
              ),
            ],
          ),
      ),
    );
  }
}
