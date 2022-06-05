import 'package:flutter/material.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/widgets/custom_dialog.dart';

class NoPermissonPopup extends StatelessWidget {
  const NoPermissonPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return CustomDialog(
      height: 120,
      message: Text(
        S.of(context).allChangesWillBeLostAreYouSureYouWant,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      buttons: [
        CustomDialogButton(
          title: S.of(context).cancel,
          action: Navigator.of(context).pop,
          color: Theme.of(context).highlightColor,
        ),
        CustomDialogButton(
          title: 'OK',
          action: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}