import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/widgets/ad_view.dart';
import 'package:snapretouch/widgets/custom_button.dart';

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
      if (mounted && result.status == ShareResultStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).backgroundColor,
          content: Text(
            S.of(context).yourImageIsShared,
            style: Theme.of(context).textTheme.bodyText1,
          ),
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
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(primaryColor: Theme.of(context).primaryColor),
        ),
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
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
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
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingSizeExtraLarge,
          horizontal: AppDimensions.paddingSizeDefault,
        ),
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
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: AppDimensions.paddingSizeDefault,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.paddingSizeDefault),
                    ),
                    color: AppColors.kTeal50,
                    // image: DecorationImage(
                    //   image: Image.file(File(image)).image,
                    //   fit: BoxFit.fill,
                    //   opacity: 0.3,
                    // ),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) => controller.state.image != null
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: (controller.state.image!.width /
                                  controller.state.image!.height),
                              child: kIsWeb
                                  ? Image.network(image)
                                  : Image.file(File(image)),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  // child: ,
                ),
              ),
              AdView(
                type: AdvertisementViewType.widget,
                adSize: AdSize.banner,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    title: S.of(context).share,
                    color: Theme.of(context).highlightColor,
                    icon: Image.asset(
                      AppImages.icShareNormal3x,
                      width: 20,
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 50,
                    titleColor: Theme.of(context).textTheme.bodyText2!.color,
                    onTap: () => shareScreenshot(context),
                  ),
                  CustomButton(
                    title: S.of(context).newImage,
                    gradient: AppColors.gradient,
                    icon: Image.asset(
                      AppImages.icAddPhotoNormal3x,
                      width: 20,
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 50,
                    onTap: () => showMenu(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
