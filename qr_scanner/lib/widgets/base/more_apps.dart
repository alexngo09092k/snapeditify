// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/config/bussiness_config/more_app.dart';
import 'package:qr_scanner/utils/widget.dart';
import 'package:qr_scanner/widgets/base/app_card.dart';
import 'package:qr_scanner/widgets/base/custom_image.dart';
import 'package:qr_scanner/widgets/base/slideshow/image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreApps extends StatelessWidget {
  const MoreApps({super.key, required this.height, required this.apps});
  final double height;
  final List<MoreApp> apps;

  _launchApp(BuildContext context, MoreApp app) async {
    try {
      if(app.link == null || !await canLaunchUrl(Uri.parse(app.link!))) throw ErrorDescription('Can not launch link');
      if (!await launchUrl(Uri.parse(app.link!))) {
        WidgetUtils.instance.showWarningPopup(
          title: "Open Brower",
          message: "Failed to open browser please try again!",
          retry: (_) => _launchApp(context, app),
        );
      }
    } catch (error) {
      Debug.log('LAUNCH URL ERROR $error');
      WidgetUtils.instance.showWarningPopup(
        title: "Open Brower",
        message: "Failed to open browser please try again!",
        retry: (_) => _launchApp(context, app),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(apps.isEmpty) return const SizedBox();
    return AppCard(
      height: height,
      child: ImageSlideshow(
        height: height,
        indicatorColor: Colors.transparent,
        indicatorRadius: 0,
        autoPlayInterval: 2000,
        isLoop:  apps.length > 1,
        children: apps
            .map(
              (e) => GestureDetector(
                onTap: () => _launchApp(context, e),
                child: Stack(
                  children: [
                   if(e.banner != null) CustomImage(image: e.banner!, height: height, fit: BoxFit.fill),
                    Padding(
                      padding: EdgeInsets.all(AppDimensions.instance.paddingX(0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.radius)),
                            child: CustomImage(
                              image: e.logo,
                              fit: BoxFit.cover,
                              height: height - AppDimensions.instance.padding,
                              width: height - AppDimensions.instance.padding,
                            ),
                          ),
                          SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color:Theme.of(context).colorScheme.onSurface),
                                    ),
                                    SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                                    Text(
                                      e.desc,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Theme.of(context).colorScheme.onSurface),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                                GestureDetector(
                                  child: Text(
                                    "Download", 
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                                  ), 
                                  onTap: () => _launchApp(context, e),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
