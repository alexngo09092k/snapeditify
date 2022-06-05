import 'package:flutter/material.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/widgets/custom_dialog.dart';

class RevertPopup extends StatelessWidget {
  RevertPopup({Key? key, required this.onRevert}) : super(key: key);

  void Function() onRevert;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
          height: 180,
          title: Text(
            S.of(context).discardChangesAndRevert,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          message: Text(
            S.of(context).allChangesWillBeLostYourImageWillBeReverted,
            style: Theme.of(context).textTheme.bodyText2,
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
                onRevert();
                Navigator.of(context).pop();
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        );
  }
}