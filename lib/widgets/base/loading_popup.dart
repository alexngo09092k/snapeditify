import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/widgets/base/app_card.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      width: 100,
      height: 100,
      color: AppColors.instance.black.withOpacity(0.1),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(
                color: AppColors.instance.white,
              ),
              if (message != null) SizedBox(height: AppDimensions.instance.padding),
              if (message != null)
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.instance.white),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
