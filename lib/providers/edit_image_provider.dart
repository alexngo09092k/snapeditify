import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/edit_image_state.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/view_models/edited_image_vm.dart';
import 'package:phosart/view_models/editing_image_vm.dart';

abstract class EditImageProvider extends Provider {
  EditImageState get state;

  late EditingImageVM _originalImage;
  EditingImageVM get originalImage => _originalImage;

  SnapEditConfig get config => Configuration.instance.snapEditConfig;

  EditedImageVM get editedImage;

  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    /// RENEW STATE
    if (refesh) await refresh(context);

    _originalImage = EditingImageVM(base64.encode(bytes));
    await _originalImage.paintParse();

    /// SET IMAGE FOR STATE
    return state.setImage(_originalImage.imageBase64);
  }

  Future<bool> refresh(BuildContext context);

  Future<bool> checkoutSaveImage(
    BuildContext context, [
    Future<bool> Function()? save,
    void Function()? canNotSave,
  ]) async {
    int downloadCount = AsyncStorage.instance.getInt(AppSharedKey.instance.downloadCount) ?? 0;
    if (downloadCount > config.maxFreeDownloadCount && canNotSave != null) {
      canNotSave();
      return false;
    } else if (save != null && await save()) {
      AsyncStorage.instance.setInt(AppSharedKey.instance.downloadCount, downloadCount + 1);
      return true;
    }
    return false;
  }

  Future<bool> saveImage(BuildContext context);

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
