import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 2 - 100),
      backgroundColor: AppColors.instance.darkBg.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.instance.paddingSizeDefault),
        height: 100,
        width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.instance.kWhite),
              ),
            ),
            SizedBox(height: AppDimensions.instance.paddingSizeDefault),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AppColors.instance.kWhite),
            ),
          ],
        ),
      ),
    );
  }
}
