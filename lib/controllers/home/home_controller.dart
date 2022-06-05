import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:snapretouch/controllers/home/home_state.dart';
import 'package:snapretouch/utils/image_pick.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController({
    required this.context,
  }) : super(HomeState());

  final BuildContext context;

  Future<void> getFromGallery() async {
    Navigator.of(context).pop();
    ImagePick.getFromGallery((pickedFile) {
      _onImagePick(pickedFile);
    });
  }

  Future<void> getFromCamera() async {
    Navigator.of(context).pop();
    ImagePick.getFromCamera((pickedFile) {
      _onImagePick(pickedFile);
    });
  }

  _onImagePick(XFile pickedFile) {
    printLog('on image picked');
    Navigator.of(context).pushNamed(AppRoutes.edit, arguments: pickedFile);
  }
}
