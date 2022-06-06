import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/home/home_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/utils/permission_checking.dart';
import 'package:snapretouch/widgets/ad_view.dart';
import 'package:snapretouch/widgets/app_logo.dart';
import 'package:snapretouch/widgets/before_after/before_after.dart';
import 'package:snapretouch/widgets/custom_button.dart';
import 'package:snapretouch/widgets/custom_card.dart';
import 'package:snapretouch/widgets/custom_overlay_state.dart';
import 'package:snapretouch/modules/painter/painter.dart';
import 'dart:ui' as ui;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends CustomOverlayState<HomePage> {
  late final HomeController _controller;

  ui.Image? _thumbImage;

  @override
  void initState() {
    _controller = HomeController(context: context);
    (() async {
     _thumbImage = await Image.asset(AppImages.beforeAfter).image.image;
     setState(() {});
    })();
    super.initState();
  }

  void showMenu() {
    PermissionChecking.requestStorePermission(
        context: context,
        onHasPermisson: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                    primaryColor: Theme.of(context).primaryColor),
              ),
              child: CupertinoActionSheet(
                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: _controller.getFromGallery,
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
                    onPressed: _controller.getFromCamera,
                    child: Text(
                      S.of(context).camera,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColor),
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
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lottieWidth = MediaQuery.of(context).size.width -
        AppDimensions.paddingSizeDefault * 2;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingSizeDefault),
                  child: AppLogo(
                    image: AppImages.imgLogoHomeNormal3x,
                    width: 160,
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdView(
                      type: AdvertisementViewType.widget,
                      width: lottieWidth,
                      height: lottieWidth * 2 / 3,
                    ),
                    Container(
                      width: lottieWidth,
                      height: lottieWidth * 2 / 3,
                      margin: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
                      child: Stack(children: [
                        CustomCard(
                          radius: AppDimensions.paddingSizeDefault,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  AppDimensions.paddingSizeDefault,
                                ),
                              ),
                              child: BeforeAfter(
                                imageWidth: lottieWidth,
                                imageHeight: lottieWidth * 2 / 3,
                                beforeImage: Image.asset(AppImages.homeBefore),
                                afterImage: Image.asset(AppImages.homeAfter),
                                thumbImage: _thumbImage,
                              )),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(
                                AppDimensions.paddingSizeDefault,
                              ),
                              width: lottieWidth * 2.5 / 3,
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: AppColors.kWhite),
                                  children: [
                                    TextSpan(
                                        text: S
                                            .of(context)
                                            .cleanYourPhotoFasterBetterWith),
                                    WidgetSpan(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          left: AppDimensions
                                              .paddingSizeExtraSmall,
                                          bottom: 5,
                                        ),
                                        child: Image.asset(
                                          AppImages.icAIHomeNormal3x,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            CustomCard(
              child: CustomButton(
                title: S.of(context).addPhoto,
                gradient: AppColors.gradient,
                icon: Image.asset(
                  AppImages.icAddPhotoNormal3x,
                  width: 30,
                ),
                width: MediaQuery.of(context).size.width * 1.5 / 3,
                height: 50,
                onTap: showMenu,
              ),
            ),
            const SizedBox(
              height: AppDimensions.paddingSizeExtraLarge,
            ),
          ],
        ),
      ),
    );
  }
}
