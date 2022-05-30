import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/common/logs.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
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

  Future<void> shareScreenshot(BuildContext context) async {
    try {
      // A builder is used to retrieve the context immediately
      // surrounding the ElevatedButton.
      //
      // The context's `findRenderObject` returns the first
      // RenderObject in its descendent tree when it's not
      // a RenderObjectWidget. The ElevatedButton's RenderObject
      // has its position and size after it's built.
      final box = context.findRenderObject() as RenderBox?;
      final List<String> imagePaths = [image];
      printLog(image);
      ShareResult result = await Share.shareFilesWithResult(
        imagePaths,
        text: '',
        subject: '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).backgroundColor,
        content: Text("Share result: ${result.status}"),
      ));
    } on PlatformException catch (e) {
      printLog("Exception while taking screenshot:$e");
    }
  }

  void showMenu(context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(primaryColor: AppColors.blue)),
        child: CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: controller.getFromGallery,
              child: Text(
                'Photo galery',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.blue,
                    ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: controller.getFromCamera,
              child: Text(
                'Camera',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blue),
              ),
            ),
          ],
          cancelButton: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue),
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
                            'Image saved!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
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
                  color: AppColors.disable,
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) =>
                        controller.state.image != null
                            ? Center(
                                child: AspectRatio(
                                  aspectRatio: (controller.state.image!.width / controller.state.image!.height),
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
                const SizedBox(
                  height: AppDimensions.paddingSizeDefault,
                ),
                Container(
                  height: 100,
                  color: AppColors.disable,
                  child: const Center(
                    child: Text('Ads banner'),
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.paddingSizeDefault,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      title: 'Share',
                      color: AppColors.disable,
                      icon: Image.asset(
                        AppImages.icShareNormal3x,
                        width: 20,
                      ),
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      height: 35,
                      textColor: Theme.of(context).textTheme.bodyMedium!.color,
                      onTap: () => shareScreenshot(context),
                    ),
                    CustomButton(
                      title: 'New image',
                      color: AppColors.blue,
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
                const SizedBox(
                  height: AppDimensions.paddingSizeExtraLarge,
                )
              ],
            ),
          ),
        ));
  }
}
