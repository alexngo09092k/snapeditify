// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/advertisement/advertisement.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/edit_image_state.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/utils/widget.dart';
import 'package:phosart/view_models/edited_image_vm.dart';
import 'package:phosart/view_models/editing_image_vm.dart';
import 'package:phosart/widgets/base/saved_mage_preview.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class EditImageProvider extends Provider {
  EditImageState get state;

  late EditingImageVM _originalImage;
  EditingImageVM get originalImage => _originalImage;

  SnapEditConfig get config => Configuration.instance.snapEditConfig;

  EditedImageVM get editedImage;

  bool get canSave;

  AwesomeAdvertisement get adProvider => ManagerProvider.of<AwesomeAdvertisement>();

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

  Future<bool> saveImage(BuildContext context) async {
    if (!canSave) return false;
    return checkoutSaveImage(context, () async {
      /// SHOW ADS
      adProvider.handleAd();

      WidgetUtils.instance.showLoadingPopup(context);

      /// SAVE IMAGE
      AssetEntity? asset = await PhotoManager.editor.saveImage(
        editedImage.imageBytes,
        title: '${Configuration.instance.businessConfig.appName}_${DateTime.now().millisecond}',
      );
      File? file = await asset?.file;

      Navigator.pop(context);

      if (file != null) {
        /// SHOW SAVED IMAGE
        showDialog(context: context, builder: (_) => SavedImagePreview(file: file));
        return true;
      }

      /// SHOW ALERT
      WidgetUtils.instance.alert(context, title: 'Save Image', message: 'Somethings wrong, please try again.');
      return false;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
      /// SHOW ALERT
      WidgetUtils.instance.alert(context, title: 'Save Image', message: 'Somethings wrong, please try again.');
    });
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
