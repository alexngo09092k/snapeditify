import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';

class AIIcon extends StatelessWidget {
  const AIIcon({Key? key, this.size = 20}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppColors.instance.gradient,
        borderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      child: Text(
        S.of(context).ai,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: AppColors.instance.kWhite),
      ),
    );
  }
}
