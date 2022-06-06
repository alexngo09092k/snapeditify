import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/widgets/custom_dialog.dart';

class GoBackPopup extends StatelessWidget {
  const GoBackPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: 160,
      message: Text(
        S.of(context).allChangesWillBeLostAreYouSureYouWant,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      buttons: [
        CustomDialogButton(
          title: S.of(context).cancel,
          action: Navigator.of(context).pop,
          color: Theme.of(context).highlightColor,
          titleColor: Theme.of(context).textTheme.bodyText1!.color,
        ),
        CustomDialogButton(
          title: S.of(context).ok,
          action: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          gradient: AppColors.gradient,
        ),
      ],
    );
  }
}
