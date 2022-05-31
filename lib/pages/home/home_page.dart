import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/home/home_controller.dart';
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
        data: const CupertinoThemeData(
            textTheme: CupertinoTextThemeData(primaryColor: AppColors.blue)),
        child: CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: _controller.getFromGallery,
              child: Text(
                'Ảnh',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blue),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: _controller.getFromCamera,
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
                  'Huỷ',
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(AppDimensions.paddingSizeDefault),
                    child: Stack(children: [
                      const CustomCard(
                        radius: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LottieView(
                              imageUrl: AppImages.homeBannerAnimation),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 180,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                AppDimensions.paddingSizeDefault),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: RichText(
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: AppColors.kWhite),
                                      children: [
                                        const TextSpan(
                                            text:
                                                'Clean your photo faster & better with'),
                                        WidgetSpan(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: AppDimensions
                                                    .paddingSizeExtraSmall,
                                                bottom: 5),
                                            child: Image.asset(
                                              AppImages.icAIHomeNormal3x,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: CustomButton(
                                      onTap: showMenu,
                                      title: 'Try it now',
                                      color: AppColors.kWhite.withOpacity(0.8),
                                      textColor: Colors.black,
                                      titleSize: 12,
                                      height: 30,
                                      width: 50,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            title: 'Add Photo',
            color: AppColors.blue,
            icon: Image.asset(
              AppImages.icAddPhotoNormal3x,
              width: 30,
            ),
            width: MediaQuery.of(context).size.width * 1.5 / 3,
            height: 50,
            onTap: showMenu,
          ),
          const SizedBox(
            height: AppDimensions.paddingSizeExtraLarge,
          ),
        ],
      ),
    );
  }
}
