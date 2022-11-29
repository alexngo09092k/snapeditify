import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/pages/home/widgets/home_banner.dart';
import 'package:snapretouch/pages/home/widgets/home_logo.dart';
import 'package:snapretouch/providers/home_provider.dart';
import 'package:snapretouch/widgets/ad_view.dart';
import 'package:snapretouch/widgets/ai_icon.dart';
import 'package:snapretouch/widgets/before_after/before_after.dart';
import 'package:snapretouch/widgets/custom_button.dart';
import 'package:snapretouch/widgets/custom_card.dart';
import 'package:snapretouch/widgets/custom_image.dart';
import 'package:snapretouch/widgets/painter/painter.dart';
import 'package:snapretouch/common/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ProviderState<HomePage, HomeProvider> {
  ui.Image? _thumbImage;

  @override
  void initState() {
    (() async {
      _thumbImage = await Image.asset(AppImages.instance.beforeAfter).image.image;
      setState(() {});
    })();
    super.initState();
  }

  void showMenu() {
    UserPermission.instance.requestStoragePermission(
        context: context,
        onHasPermisson: () {
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
                    onPressed: () => provider.getFromGallery(context),
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
                    onPressed: () => provider.getFromCamera(context),
                    child: Text(
                      S.of(context).camera,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.normal, color: Theme.of(context).primaryColor),
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
  Widget build(BuildContext context) {
    final lottieWidth = MediaQuery.of(context).size.width - AppDimensions.instance.paddingSizeDefault * 2;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppDimensions.instance.paddingSizeDefault),
                  child: const HomeLogo(),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdView(
                      size: Size(lottieWidth, lottieWidth * 2 / 3),
                      loadingWidget: HomeBanner(
                        width: lottieWidth,
                        height: lottieWidth * 2 / 3,
                      ),
                      screenName: AppRoutes.homePage,
                    ),
                    Container(
                      width: lottieWidth,
                      height: lottieWidth * 2 / 3,
                      margin: EdgeInsets.all(
                        AppDimensions.instance.paddingSizeDefault,
                      ),
                      child: Stack(children: [
                        CustomCard(
                          radius: AppDimensions.instance.paddingSizeDefault,
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  AppDimensions.instance.paddingSizeDefault,
                                ),
                              ),
                              child: BeforeAfter(
                                imageWidth: lottieWidth,
                                imageHeight: lottieWidth * 2 / 3,
                                beforeImage: CustomImage(image: AppImages.instance.homeBefore),
                                afterImage: CustomImage(image: AppImages.instance.homeAfter),
                                thumbImage: _thumbImage,
                              )),
                        ),
                        Positioned(
                            child: Container(
                          padding: EdgeInsets.all(
                            AppDimensions.instance.paddingSizeDefault,
                          ),
                          width: lottieWidth * 2.5 / 3,
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: AppColors.instance.kWhite,
                                  ),
                              children: [
                                TextSpan(text: S.of(context).cleanYourPhotoFasterBetterWith),
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: AppDimensions.instance.paddingSizeExtraSmall,
                                      bottom: AppDimensions.instance.paddingSizeExtraSmall - 3,
                                    ),
                                    child: const AIIcon(),
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
                gradient: AppColors.instance.gradient,
                icon: Image.asset(
                  AppImages.instance.icAddPhotoNormal3x,
                  width: 30,
                ),
                width: MediaQuery.of(context).size.width * 1.5 / 3,
                height: 50,
                onTap: showMenu,
              ),
            ),
            SizedBox(
              height: AppDimensions.instance.paddingSizeExtraLarge,
            ),
          ],
        ),
      ),
    );
  }
}
