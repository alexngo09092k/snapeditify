import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/video_player.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class SavedVideoPreview extends StatelessWidget {
  const SavedVideoPreview({
    super.key,
    required this.editedImage,
    required this.videoURL,
    required this.savedFile,
    required this.onShare,
    required this.onNewImage,
  });
  final EditedImageVM editedImage;
  final String videoURL;
  final File savedFile;
  final Function() onShare;
  final Function() onNewImage;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.only(top: AwesomeAppState.screen.height * 1 / 5),
      color: Theme.of(context).colorScheme.background,
      height: AwesomeAppState.screen.height * 4 / 5,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimensions.instance.paddingX(2)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saved Video",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: const CustomIcon(CupertinoIcons.clear),
                    )
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.instance.padding),
              Expanded(
                child: AspectRatio(
                  aspectRatio: editedImage.ratio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(child: VideoPlayer(videoURL: videoURL)),
                      LottieViewer(
                        lottie: AppAssets.instance.confetti, 
                        repeat: false,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.instance.padding),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      title: S.of(context).newImage,
                      width: 150,
                      height: 40,
                      color: Theme.of(context).colorScheme.surface,
                      titleColor: Theme.of(context).colorScheme.onSurface,
                      onTap: () {
                        Navigator.of(context).pop();
                        onNewImage();
                      },
                    ),
                    CustomButton(
                      title: S.of(context).share,
                      width: 150,
                      height: 40,
                      gradient: AppColors.instance.gradient,
                      onTap: () {
                        Navigator.of(context).pop();
                        onShare();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}