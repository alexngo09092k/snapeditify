import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_view.dart';
import 'package:snapedit/widgets/ad_view.dart';
import 'package:snapedit/widgets/custom_button.dart';
import 'package:snapedit/widgets/ui_image_display.dart';

class SavedImageView extends StatelessWidget {
  const SavedImageView({
    Key? key,
    required this.controller,
    required this.image,
  }) : super(key: key);
  final EditController controller;
  final String image;
  static final GlobalKey _globalKey = GlobalKey();

  bool get mounted {
    return true;
  }

  Future<void> shareScreenshot(BuildContext context) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      final List<String> imagePaths = [image];
      ShareResult result = await Share.shareFilesWithResult(
        imagePaths,
        text: '',
        subject: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Text(S.of(context).yourImageIsShared),
        ));
      }
    } on PlatformException catch (e) {
      printLog("Exception while taking screenshot:$e");
    }
  }

  void showMenu(context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(textTheme: CupertinoTextThemeData(primaryColor: Theme.of(context).primaryColor)),
        child: CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: controller.getFromGallery,
              child: Text(
                S.of(context).photoGallery,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: controller.getFromCamera,
              child: Text(
                S.of(context).camera,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
          cancelButton: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  S.of(context).cancel,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 2 / 3;
    return RepaintBoundary(
        key: _globalKey,
        child: Container(
          height: height,
          padding: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppImages.icGreenCheckmarkNormal3x,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: AppDimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            S.of(context).imageSaved,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  color: Theme.of(context).highlightColor,
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) => controller.state.image != null
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: (controller.state.image!.width /
                                  controller.state.image!.height),
                              child: UIImageDisplay(
                                uiImage: controller.state.image!,
                                placeholder: const SizedBox(),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  // child: ,
                )),
                const SizedBox(height: AppDimensions.paddingSizeDefault),
                AdView(type: AdvertisementViewType.widget, adSize: AdSize.banner, width: MediaQuery.of(context).size.width),
                const SizedBox(height: AppDimensions.paddingSizeDefault),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      title: S.of(context).share,
                      color: Theme.of(context).backgroundColor,
                      icon: Image.asset(
                        AppImages.icShareNormal3x,
                        width: 20,
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 35,
                      textColor: Theme.of(context).textTheme.bodyText2!.color,
                      onTap: () => shareScreenshot(context),
                    ),
                    CustomButton(
                      title: S.of(context).newImage,
                      icon: Image.asset(
                        AppImages.icAddPhotoNormal3x,
                        width: 20,
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 35,
                      onTap: () => showMenu(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingSizeExtraLarge)
              ],
            ),
          ),
        ));
  }
}
