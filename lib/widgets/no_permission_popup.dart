import 'package:flutter/material.dart';
import 'package:snapedit/widgets/custom_dialog.dart';
import 'package:snapedit/common/constants.dart';

class NoPermissonPopup extends StatelessWidget {
  const NoPermissonPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return CustomDialog(
      height: 120,
      message: Text(
        'All changes will be lost. Are you sure you want to leave wihthout saving?',
        textAlign: TextAlign.center,
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
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          color: AppColors .blue,
        ),
      ],
    );
  }
}