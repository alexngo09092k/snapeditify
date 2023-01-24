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
import 'package:phosart/widgets/base/custom_alert.dart';
import 'package:phosart/widgets/base/saved_mage_preview.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class EditImageProvider extends Provider {
  EditImageState get state;

  late EditingImageVM _originalImage;
  EditingImageVM get originalImage => _originalImage;

  SnapEditConfig get config => Configuration.instance.snapEditConfig;

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

      WidgetUtils.instance.showLoadingPopup(context, message: 'Please wait a moment!');

      Navigator.pop(context);

      /// SAVE IMAGE
      AssetEntity? asset = await PhotoManager.editor.saveImage(
        editedImage.imageBytes,
        title: '${Configuration.instance.businessConfig.appName}_${DateTime.now().millisecond}',
      );

      _savedFile = (await asset?.file);

      if (_savedFile != null) {
        /// SHOW SAVED IMAGE
        return (await showModalBottomSheet<bool>(
              context: context,
              builder: (_) => SavedImagePreview(provider: this),
            )) ??
            false;
      }

      /// SHOW ALERT
      WidgetUtils.instance.alert(
        context,
        title: 'Save Image',
        message: 'Somethings wrong, please try again.',
        actions: [
          AlertAction(title: 'Cancel', onPressed: Navigator.of(context).pop),
          AlertAction(
            title: 'Retry',
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              saveImage(context);
            },
          ),
        ],
      );
      return false;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
      /// SHOW ALERT
      WidgetUtils.instance.alert(
        context,
        title: 'Save Image',
        message: 'Somethings wrong, please try again.',
        actions: [
          AlertAction(title: 'Cancel', onPressed: Navigator.of(context).pop),
          AlertAction(
            title: 'Retry',
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              saveImage(context);
            },
          ),
        ],
      );
    });
  }

  goBack(BuildContext context) {
    if (!canBack) {
      WidgetUtils.instance.alert(context, message: 'Are you sure cancel all edit image', actions: [
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
            })
      ]);
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
