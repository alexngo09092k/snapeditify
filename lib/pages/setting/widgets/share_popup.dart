import 'package:flutter/material.dart';
import 'package:phosart/common/constants.dart';

class SharePopup extends StatelessWidget {
  const SharePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: AppDimensions.instance.popup,
        padding: EdgeInsets.all(AppDimensions.instance.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.instance.radius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    AppAssets.instance.icClose,
                    width: AppDimensions.instance.icon,
                  ),
                ),
              ],
            ),
            Image.asset(
              AppAssets.instance.bgShareImage,
              width: AppDimensions.instance.popup * 2 / 3,
            ),
            SizedBox(height: AppDimensions.instance.padding),
            Text(
              'Share SnapEdit App',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.instance.padding),
            Text(
              "Let's share one of the best photo editing app with your friends, family and community",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: AppDimensions.instance.padding),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.instance.radiusX(2)),
                  ),
                ),
                child: Text(
                  'Share',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
