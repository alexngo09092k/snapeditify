// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/change_bg/change_bg_provider.dart';
import 'package:snapeditify/providers/remove_bg/remove_bg_provider.dart';
import 'package:snapeditify/widgets/base/custom_button.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';

class RemoveBGControl extends StatelessWidget {
  const RemoveBGControl({super.key});

  _onEditBG(BuildContext context) async {
    LoadingPopup.show();
    try {
      IRemoveBGProvider rmBGProvider = ManagerProvider.of<IRemoveBGProvider>();
      IChangeBGProvider changeBGProvider = ManagerProvider.of<IChangeBGProvider>();
      Uint8List? imageBytes = await rmBGProvider.captureController.capture();

      bool ok = false;
      if (imageBytes != null) {
        ok = await changeBGProvider.setImage(context, bytes: imageBytes);
      }

      if (ok) {
        Navigator.pushNamed(context, AppRoutes.changeBG);
      }
    } finally {
      LoadingPopup.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          title: S.of(context).editBackground,
          height: 50,
          icon: CustomIcon(Icons.edit, color: AppColors.instance.white),
          onTap: () => _onEditBG(context),
        )
      ],
    );
  }
}
