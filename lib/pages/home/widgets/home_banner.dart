import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key, this.width, this.height}) : super(key: key);
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(AppDimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(AppImages.homeBanner).image,
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
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
        Image.asset(
          AppImages.icCheckboxSelectedNormal3x,
          width: 16,
        ),
        const SizedBox(width: AppDimensions.paddingSizeExtraSmall),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(),
        ),
      ],
    );
  }
}
