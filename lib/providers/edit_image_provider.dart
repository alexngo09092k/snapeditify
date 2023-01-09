import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/configuration.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/providers/edit_image_state.dart';
import 'package:phosart/services/services.dart';
import 'package:phosart/utils/image.dart';

abstract class EditImageProvider extends Provider {
  EditImageState get state;

  late ui.Image _imageUI;
  ui.Image get imageUI => _imageUI;

  late String _imageBase64;
  String get imageBase64 => _imageBase64;

  late Uint8List _imageBytes;
  Uint8List get imageBytes => _imageBytes;

  SnapEditConfig get config => Configuration.instance.snapEditConfig;

  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    /// RENEW STATE
    if (refesh) await refresh(context);

    _imageBytes = bytes;
    _imageBase64 = base64.encode(bytes);

    /// CREATE IMAGE UI
    _imageUI = await ImageUtils.instance.base64ToImageUI(imageBase64);

    Debug.log("====== PROVIDER SET IMAGE DONE ======");

    /// SET IMAGE FOR STATE
    return state.setImage(imageBase64, provider: this);
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
