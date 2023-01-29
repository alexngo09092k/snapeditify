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
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/edit_image_state.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/view_models/editing_image_vm.dart';
import 'package:snapeditify/widgets/base/custom_alert.dart';
import 'package:snapeditify/widgets/base/saved_mage_preview.dart';
import 'package:snapeditify/common/extensions.dart';

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
    int saveCount = AsyncStorage.instance.getInt(AsyncStorageKey.instance.saveCount) ?? 0;
    Debug.log("Checkout save image count $saveCount");
    if (saveCount > config.maxFreeDownloadCount && canNotSave != null) {
      canNotSave();
      return false;
    } else if (save != null && await save()) {
      AsyncStorage.instance.setInt(AsyncStorageKey.instance.saveCount, saveCount + 1);
      return true;
    }
    return false;
  }

  Future<bool> saveImage(BuildContext context) async {
    if (!canSave) return false;
    return checkoutSaveImage(context, () async {
      /// SHOW ADS
      // adProvider.handleAd();

      if (_savedFile == null) {
        /// SHOW LOADING
        WidgetUtils.instance.showLoadingPopup(context, message: S.of(context).pleaseWaitAMoment);

        /// SAVE IMAGE
        _savedFile = await ManagerProvider.of<GalleryProvider>().saveImage(editedImage.imageBytes);

        /// HIDE LOADING
        Navigator.pop(context);
      }

      if (_savedFile != null) {
        /// SHOW SAVED IMAGE
        await showModalBottomSheet<bool>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.instance.radius),
          ),
          builder: (_) => SavedImagePreview(provider: this),
        );
        return true;
      }

      /// SHOW ALERT
      WidgetUtils.instance.showErrorPopup(context, title: S.of(context).saveImage, retry: saveImage);
      return false;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
      /// SHOW ALERT

      WidgetUtils.instance.showErrorPopup(
        context,
        title: S.of(context).saveImageLimit,
        message:
            '${S.of(context).youHaveReachedTheLimitOfSavedImagePleaseUpgrade} ${Configuration.instance.business.appName} ${S.of(context).teamToSupport}',
        retry: saveImage,
      );
    });
  }

  Future<bool> checkEnviroment(BuildContext context, {void Function(BuildContext)? retry}) async {
    final result = await ClientHttp.instance.safeEnvironment();
    if (!result) {
      WidgetUtils.instance.showNoInternetPopup(context, retry: retry);
    }
    return result;
  }

  Future<bool> goBack(BuildContext context, [bool onPop = false]) async {
    if (!canBack) {
      return (await WidgetUtils.instance.alert<bool>(
            context,
            message: S.of(context).allChangesWillBeLostAreYouSureYouWant,
            actions: [
              AlertAction(
                title: S.of(context).cancel,
                onPressed: () {
                  Navigator.pop<bool>(context, false);
                },
              ),
              AlertAction(
                title: S.of(context).ok,
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context, true);
                  if (!onPop) Navigator.pop(context, true);
                },
              )
            ],
          ) ??
          canBack);
    }
    if (!onPop) {
      Navigator.pop(context);
    }
    return canBack;
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
