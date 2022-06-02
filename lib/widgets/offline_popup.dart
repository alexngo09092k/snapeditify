import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/custom_button.dart';

class OfflinePopup extends StatelessWidget {
  const OfflinePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2 - AppDimensions.paddingSizeDefault;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSizeDefault,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSizeDefault),
        width: width,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.imgOfflineNormal3x,
              width: width,
              height: 100,
            ),
            const SizedBox(height: AppDimensions.paddingSizeDefault,),
            Text(
              'You are currently offline!',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!.copyWith(fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: AppDimensions.paddingSizeDefault),
            Text(
              'Looks like your connection is interrupted. Check network connection and try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption!
            ),
            const SizedBox(height: AppDimensions.paddingSizeLarge),
            CustomButton(
              title: 'OK',
              color: Theme.of(context).primaryColor,
              width: width * 2,
              height: 30,
              onTap: Navigator.of(context).pop,
            ),
          ],
        ),
      ),
    );
  }
}
