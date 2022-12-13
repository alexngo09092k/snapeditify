import 'package:flutter/material.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/common/extensions.dart';
import 'package:snapedit/providers/gallery/gallery_provider.dart';

class HomeOptionsModal extends StatelessWidget {
  const HomeOptionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _Option(
                  title: "Remove\nObject",
                  icon: AppAssets.instance.icRemoveObject,
                  color: Colors.red,
                  onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.removeObject),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                child: _Option(
                  title: "Remove\nObject",
                  icon: AppAssets.instance.icEnhence,
                  color: Colors.red,
                  onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.enhanceImage),
                ),
              ),
              SizedBox(width: AppDimensions.instance.padding),
              Expanded(
                child: _Option(
                  title: "Remove\nObject",
                  icon: AppAssets.instance.icArtEffect,
                  color: Colors.red,
                  onTap: (_) => AppRoutes.instance.goGalleryPage(context, EditImageType.applyArtEffect),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({Key? key, required this.title, required this.icon, required this.onTap, required this.color}) : super(key: key);

  final String title;
  final String icon;
  final Function(BuildContext) onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
        child: Container(
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          decoration: BoxDecoration(
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(icon),
              SizedBox(height: AppDimensions.instance.padding),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
