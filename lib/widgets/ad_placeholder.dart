import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';

class AdPlaceHolder extends StatelessWidget {
  const AdPlaceHolder({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(AppDimensions.instance.padding),
      decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: Image.asset(AppAssets.instance.placeholder).image,
          //   fit: BoxFit.fill,
          // ),
          ),
      child: Stack(
        children: [
          // CustomImage(
          //   image: AppAssets.instance.placeholder,
          //   width: width,
          //   height: height,
          // ),
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
          color: AppColors.instance.blue,
        ),
        // Image.asset(
        //   AppAssets.instance.icCheckboxSelectedNormal3x,
        //   width: 16,
        // ),
        SizedBox(width: AppDimensions.instance.paddingX(0.5)),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(),
        ),
      ],
    );
  }
}
