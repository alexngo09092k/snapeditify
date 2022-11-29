import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/utils/image_pick.dart';

abstract class IHomeProvider extends Provider {
  Future<void> getFromGallery(BuildContext context);

  Future<void> getFromCamera(BuildContext context);
}

class HomeProvider extends IHomeProvider {
  @override
  Future<void> getFromGallery(BuildContext context) async {
    // Navigator.of(context).pop();
    ImagePick.getFromGallery((pickedFile) {
      _onImagePick(context, pickedFile);
    });
  }

  @override
  Future<void> getFromCamera(BuildContext context) async {
    // Navigator.of(context).pop();
    ImagePick.getFromCamera((pickedFile) {
      _onImagePick(context, pickedFile);
    });
  }

  _onImagePick(BuildContext context, File pickedFile) {
    Debug.log('on image picked');
    Navigator.of(context).pushNamed(AppRoutes.editPage, arguments: pickedFile);
  }
}
