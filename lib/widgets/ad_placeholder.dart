import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/widgets/custom_image.dart';

class AdPlaceHolder extends StatelessWidget {
  const AdPlaceHolder({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(AppDimensions.instance.paddingSizeDefault),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(AppImages.instance.placeholder).image,
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          CustomImage(
            image: AppImages.instance.placeholder,
            width: width,
            height: height,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _GroupIcon(
                    title: S.of(context).automatic,
                  ),
                  _GroupIcon(
                    title: S.of(context).free,
                  ),
                  _GroupIcon(
                    title: S.of(context).betterQuality,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _GroupIcon extends StatelessWidget {
  const _GroupIcon({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 16,
          color: AppColors.instance.lightActive,
        ),
        // Image.asset(
        //   AppImages.instance.icCheckboxSelectedNormal3x,
        //   width: 16,
        // ),
        SizedBox(width: AppDimensions.instance.paddingSizeExtraSmall),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(),
        ),
      ],
    );
  }
}
