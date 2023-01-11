import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosart/common/constants.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(color: AppColors.instance.black.withOpacity(0.1)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Theme(
                data: ThemeData(indicatorColor: AppColors.instance.white),
                child: const CupertinoActivityIndicator(),
              ),
            ],
          ),
          if (message != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              ],
            )
        ],
      ),
    );
  }
}
