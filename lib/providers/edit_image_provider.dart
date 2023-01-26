// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/advertisement/advertisement.dart';
import 'package:snapeditify/common/configuration.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/view_models/editing_image_vm.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';
import 'package:snapeditify/widgets/base/saved_mage_preview.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class EditImageProvider extends Provider {
  EditImageState get state;

  late EditingImageVM _originalImage;
  EditingImageVM get originalImage => _originalImage;

  SnapEditConfig get config => Configuration.instance.snapEdit;

  EditedImageVM get editedImage;

  bool get canSave;

  File? _savedFile;
  File? get savedFile => _savedFile;

  bool get canBack => _savedFile != null || (!canSave && _savedFile == null);

  AwesomeAdvertisement get adProvider => ManagerProvider.of<AwesomeAdvertisement>();

  renewSavedFile() {
    _savedFile = null;
  }

  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    /// RENEW STATE
    if (refesh) await refresh(context);

    _originalImage = EditingImageVM(base64.encode(bytes));
    await _originalImage.paintParse();

    /// SET IMAGE FOR STATE
    return state.setImage(_originalImage.imageBase64);
  }

  Future<bool> refresh(BuildContext context) async {
    _savedFile = null;
    return true;
  }

  Future<bool> checkoutSaveImage(
    BuildContext context, [
    Future<bool> Function()? save,
    void Function()? canNotSave,
  ]) async {
    int saveCount = AsyncStorage.instance.getInt(AppSharedKey.instance.saveCount) ?? 0;
    Debug.log("Checkout save image count $saveCount");
    if (saveCount > config.maxFreeDownloadCount && canNotSave != null) {
      canNotSave();
      return false;
    } else if (save != null && await save()) {
      AsyncStorage.instance.setInt(AppSharedKey.instance.saveCount, saveCount + 1);
      return true;
    }
    return false;
  }

  Future<bool> saveImage(BuildContext context) async {
    if (!canSave) return false;
    return checkoutSaveImage(context, () async {
      /// SHOW ADS
      adProvider.handleAd();

      WidgetUtils.instance.showLoadingPopup(context, message: 'Please wait a moment!');

      Navigator.pop(context);

      /// SAVE IMAGE
      AssetEntity? asset = await PhotoManager.editor.saveImage(
        editedImage.imageBytes,
        title: '${Configuration.instance.business.appName}_${DateTime.now().millisecond}',
      );

      _savedFile = (await asset?.file);

      if (_savedFile != null) {
        /// SHOW SAVED IMAGE
        await showModalBottomSheet<bool>(
          context: context,
          builder: (_) => SavedImagePreview(provider: this),
        );
        return true;
      }

      /// SHOW ALERT
      WidgetUtils.instance.showErrorPopup(context, title: 'Save Image', retry: saveImage);
      return false;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
      /// SHOW ALERT

      WidgetUtils.instance.showErrorPopup(
        context,
        title: 'Save Image Limit',
        message: 'You have reached the limit of saved image, please upgrade premium version or contact ${Configuration.instance.business.appName} Team to support.',
        retry: saveImage,
      );
    });
  }

  goBack(BuildContext context) {
    if (!canBack) {
      WidgetUtils.instance.alert(
        context,
        message: 'All changes will be lost. Are you sure you want to leave without saving?',
        actions: [
          AlertAction(
            title: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          AlertAction(
            title: 'Ok',
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
