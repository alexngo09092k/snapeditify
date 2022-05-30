import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/widgets/custom_dialog.dart';

class RevertPopup extends StatelessWidget {
  RevertPopup({Key? key, required this.onRevert}) : super(key: key);

  void Function() onRevert;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
          height: 150,
          title: Text(
            'Discard changes and revert',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          message: Text(
            'All changes will be lost. Your image will be reverted to its original status',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          buttons: [
            CustomDialogButton(
              title: 'Cancel',
              action: Navigator.of(context).pop,
              color: Theme.of(context).disabledColor,
            ),
            CustomDialogButton(
              title: 'OK',
              action: () {
                onRevert();
                Navigator.of(context).pop();
              },
              color: AppColors.blue,
            ),
          ],
        );
  }
}