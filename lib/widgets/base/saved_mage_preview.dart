import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class SavedImagePreview extends StatelessWidget {
  const SavedImagePreview({super.key, required this.provider});
  final EditImageProvider provider;

  @override
  Widget build(BuildContext context) {
    final gallery = ManagerProvider.of<GalleryProvider>();
    return AppCard(
      height: AwesomeAppState.screen.height * 2 / 3,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding, vertical: AppDimensions.instance.paddingX(2)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).savedImage,
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: const CustomIcon(CupertinoIcons.clear),
                  )
                ],
              ),
              SizedBox(height: AppDimensions.instance.padding),
              Expanded(
                child: AspectRatio(
                  aspectRatio: provider.editedImage.ratio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                        provider.savedFile!,
                        fit: BoxFit.cover,
                        width: AwesomeAppState.screen.width,
                      ),
                      LottieViewer(lottie: AppAssets.instance.confetti, repeat: false)
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.instance.padding),
              _Options(current: gallery.editImageType, provider: provider),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    title: S.of(context).newImage,
                    width: 150,
                    height: 40,
                    color: AppColors.instance.white,
                    titleColor: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    title: S.of(context).share,
                    width: 150,
                    height: 40,
                    gradient: AppColors.instance.gradient,
                    onTap: () => Share.shareXFiles(
                      [XFile(provider.savedFile!.path)],
                      subject: Configuration.instance.business.shareApp.message,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({this.current, required this.provider});
  final EditImageType? current;
  final EditImageProvider provider;

  @override
  Widget build(BuildContext context) {
    final lottieWidth = AppDimensions.instance.bannerWidth;
    final itemWidth = lottieWidth / 4 - AppDimensions.instance.padding;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: EditImageType.values
            .where((element) => element != current)
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    AppRoutes.instance.goEditImagePage(
                      context,
                      bytes: provider.editedImage.imageBytes,
                      editImageType: e,
                    );
                  },
                  child: AppCard(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppDimensions.instance.paddingX(0.25),
                      vertical: AppDimensions.instance.padding,
                    ),
                    width: itemWidth,
                    height: itemWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIcon(e.icon),
                        SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                        Text(e.title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
