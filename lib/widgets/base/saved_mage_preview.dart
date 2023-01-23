import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/edit_image_provider.dart';
import 'package:phosart/widgets/base/app_card.dart';
import 'package:phosart/widgets/base/custom_button.dart';
import 'package:phosart/widgets/base/custom_icon.dart';
import 'package:share_plus/share_plus.dart';

class SavedImagePreview extends StatelessWidget {
  const SavedImagePreview({super.key, required this.provider});
  final EditImageProvider provider;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      height: AwesomeAppState.screen.height * 2 / 3,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimensions.instance.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saved Image',
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppColors.instance.mediumSlateBlue),
                  ),
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: CustomIcon(
                      AppAssets.instance.icClose,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: provider.editedImage.ratio,
                child: Image.file(
                  provider.savedFile!,
                  fit: BoxFit.cover,
                  width: AwesomeAppState.screen.width,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppDimensions.instance.padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    title: 'NEW IMAGE',
                    width: 150,
                    height: 40,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    title: 'SHARE',
                    width: 150,
                    height: 40,
                    onTap: () => Share.shareXFiles([XFile(provider.savedFile!.path)]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
