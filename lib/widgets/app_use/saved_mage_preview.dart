import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/base/app_card.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/lottie_viewer.dart';

class SavedImagePreview extends StatelessWidget {
  const SavedImagePreview({
    super.key,
    required this.editedImage,
    required this.editImageType,
    required this.onNewEditImage,
    required this.savedFile,
    required this.onShare,
    required this.onNewImage,
  });
  final EditedImageVM editedImage;
  final EditImageType editImageType;
  final File savedFile;
  final Function(EditImageType) onNewEditImage;
  final Function() onShare;
  final Function() onNewImage;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: Theme.of(context).colorScheme.background,
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).primaryColor),
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
                  aspectRatio: editedImage.ratio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                        savedFile,
                        fit: BoxFit.cover,
                        width: AwesomeAppState.screen.width,
                      ),
                      LottieViewer(lottie: AppAssets.instance.confetti, repeat: false)
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.instance.padding),
              _Options(
                current: editImageType,
                onOptions: (_) {
                  Navigator.of(context).pop();
                  onNewEditImage(_);
                },
              ),
              SizedBox(height: AppDimensions.instance.padding),
              Row(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options({this.current, required this.onOptions});
  final EditImageType? current;
  final Function(EditImageType) onOptions;

  @override
  Widget build(BuildContext context) {
    final contentMaxWidth = AppDimensions.instance.contentMaxWidth;
    final itemWidth = contentMaxWidth / 4 - AppDimensions.instance.padding;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.instance.padding)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: EditImageType.values
            .where((element) => element != current)
            .map((e) => GestureDetector(
                  onTap: () => onOptions(e),
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
                        Text(e.title, style: Theme.of(context).textTheme.bodyLarge)
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
