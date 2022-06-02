import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/home/home_controller.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/modules/advertisement/models/advertisement_view.dart';
import 'package:snapedit/widgets/ad_view.dart';
import 'package:snapedit/widgets/app_logo.dart';
import 'package:snapedit/widgets/custom_button.dart';
import 'package:snapedit/widgets/custom_card.dart';
import 'package:snapedit/widgets/custom_overlay_state.dart';
import 'package:snapedit/widgets/lottie_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends CustomOverlayState<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController(context: context);
  }

  void showMenu() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(textTheme: CupertinoTextThemeData(primaryColor: Theme.of(context).primaryColor)),
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
            child:  Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lottieWidth = MediaQuery.of(context).size.width -
        AppDimensions.paddingSizeDefault * 2;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 130,
        leading: const Padding(
          padding: EdgeInsets.only(left: AppDimensions.paddingSizeDefault),
          child: AppLogo(
            image: AppImages.imgLogoHomeNormal3x,
            width: 130,
          ),
        ),
      ),
      body: Column(
        children: [
          AdView(
            type: AdvertisementViewType.widget,
            width: lottieWidth,
            height: lottieWidth * 2 / 3,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: lottieWidth,
                    height: lottieWidth * 2 / 3,
                    margin:
                        const EdgeInsets.all(AppDimensions.paddingSizeDefault),
                    child: Stack(children: [
                      CustomCard(
                        radius: AppDimensions.paddingSizeDefault,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              AppDimensions.paddingSizeDefault,
                            ),
                          ),
                          child: LottieView(
                            imageUrl: AppImages.homeBannerAnimation,
                            width: lottieWidth,
                            height: lottieWidth * 2 / 3,
                          ),
                        ),
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
                                        left: AppDimensions.paddingSizeExtraSmall,
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
              color: Theme.of(context).primaryColor,
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
    );
  }
}
