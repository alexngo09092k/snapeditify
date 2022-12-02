// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttering/fluttering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapedit/common/app_routes.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/edit_provider/edit_provider.dart';
import 'package:snapedit/widgets/ad_view.dart';
import 'package:snapedit/widgets/custom_button.dart';
import 'dart:ui' as ui;

class SavedImageView extends StatelessWidget {
  const SavedImageView({
    Key? key,
    required this.imagePath,
    required this.originalImageBase64,
  }) : super(key: key);
  final String imagePath;
  final String originalImageBase64;
  static final GlobalKey _globalKey = GlobalKey();

  bool get mounted {
    return true;
  }

  Future<void> shareScreenshot(BuildContext context) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      final List<String> imagePaths = [imagePath];
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
      Debug.log("Exception while taking screenshot:$e");
    }
  }

  void showMenu(context) {
    EditProvider p = ManagerProvider.of<EditProvider>();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.light,
          textTheme: CupertinoTextThemeData(
            primaryColor: Theme.of(context).primaryColor,
          ),
        ),
        child: CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => p.getFromGallery(context),
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
              onPressed: () => p.getFromCamera(context),
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
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.instance.paddingSizeExtraLarge,
          horizontal: AppDimensions.instance.padding,
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
                          AppAssets.instance.icGreenCheckmarkNormal3x,
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: AppDimensions.instance.paddingSizeExtraSmall,
                        ),
                        Text(
                          S.of(context).imageSaved,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
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
              SizedBox(
                height: AppDimensions.instance.padding,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.instance.padding),
                    ),
                    color: AppColors.instance.lightActive,
                    // image: DecorationImage(
                    //   image: Image.file(File(image)).image,
                    //   fit: BoxFit.fill,
                    //   opacity: 0.3,
                    // ),
                  ),
                  child: PropConsumer<EditProvider, ui.Image?>(
                    select: (p) => p.state.image,
                    builder: (_, __, p, ___) => p.state.image != null
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: (p.state.image!.width / p.state.image!.height),
                              child: CurrentPlatform.instance.kIsWeb ? Image.network(imagePath) : Image.file(File(imagePath)),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  // child: ,
                ),
              ),
              AdView(
                size: Size(MediaQuery.of(context).size.width, 60),
                screenName: AppRoutes.removeObjectPage,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    title: S.of(context).share,
                    color: Theme.of(context).highlightColor,
                    icon: Image.asset(
                      AppAssets.instance.icShareNormal3x,
                      width: 20,
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: 50,
                    titleColor: Theme.of(context).textTheme.bodyText2!.color,
                    onTap: () => shareScreenshot(context),
                  ),
                  CustomButton(
                    title: S.of(context).newImage,
                    gradient: AppColors.instance.gradient,
                    icon: Image.asset(
                      AppAssets.instance.icAddPhotoNormal3x,
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
