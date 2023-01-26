import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class SavedImagePreview extends StatelessWidget {
  const SavedImagePreview({super.key, required this.provider});
  final EditImageProvider provider;

  @override
  Widget build(BuildContext context) {
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
                    'Saved Image',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    title: 'NEW IMAGE',
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
                    title: 'SHARE',
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
