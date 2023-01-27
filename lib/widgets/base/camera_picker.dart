// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/utils/image.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class CameraPicker extends StatelessWidget {
  const CameraPicker({super.key});

  _onPickCamera(BuildContext context) async {
    File? file = await ImageUtils.instance.pickImage(ImageSource.camera);
    if (file != null) {
      AppRoutes.instance.goEditImagePage(context, bytes: file.readAsBytesSync());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPickCamera(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.padding),
        child: const CustomIcon(CupertinoIcons.camera),
      ),
    );
  }
}
