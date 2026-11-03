// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snapeditify/common/app_routes.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/enhance/widgets/enhance_guide.dart';
import 'package:snapeditify/providers/edit_image_provider.dart';
import 'package:snapeditify/providers/gallery/gallery_provider.dart';
import 'package:snapeditify/providers/restore/restore_state.dart';
import 'package:snapeditify/services/services.dart';
import 'package:snapeditify/utils/widget.dart';
import 'package:snapeditify/view_models/edited_image_vm.dart';
import 'package:snapeditify/widgets/app_use/painter/painter.dart';
import 'package:snapeditify/widgets/app_use/saved_video_preview.dart';
import 'package:snapeditify/widgets/base/loading_popup.dart';
import 'package:snapeditify/common/configuration.dart';

abstract class IRestoreProvider extends EditImageProvider {
  @override
  RestoreState get state;

  PainterController get paintBefore;

  PageController get tabController;

  Future<bool> restoreImage(BuildContext context);

  Future<bool> videoEffect(BuildContext context);

  Future<bool> saveVideo(BuildContext context);

  bool showEnhanceGuide();
}

class RestoreProvider extends IRestoreProvider {
  static final IRestoreProvider _instance = RestoreProvider.internal();

  static IRestoreProvider get instance => _instance;

  RestoreProvider.internal() {
    _state = RestoreState();
    _state.addListener(notifyListeners);

    _paintBefore = PainterController();
    _paintBefore.addListener(notifyListeners);

    _tabController = PageController();
  }

  late RestoreState _state;
  @override
  RestoreState get state => _state;

  late PainterController _paintBefore;
  @override
  PainterController get paintBefore => _paintBefore;

  @override
  EditedImageVM get editedImage => EditedImageVM(_state.image.imageBytes, _state.image.imageUI);

  @override
  bool get canSave =>  _state.image.imageBase64 != originalImage.imageBase64;

  late PageController _tabController;
  @override
  PageController get tabController => _tabController;

  @override
  Future<bool> setImage(BuildContext context, {required Uint8List bytes, bool refesh = true}) async {
    final result = await super.setImage(context, bytes: bytes, refesh: refesh);
    if(result) {
      _paintBefore.background = originalImage.imageUI.backgroundDrawable;
    }
    return result;
  }

  @override
  Future<bool> restoreImage(BuildContext context) async {
    /// MAKED VIDEO
    if(canSave) return true;

    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => restoreImage(context));
    if (!result) return false;

    renewSavedFile();

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    try {
      /// SHOW ADS
      adProvider.handleAd();

      /// CALL API
      RestoreBody body = RestoreBody(inputImage: _state.image.imageBytes, imageId: _state.imageId);
      final SnapEditResponse<RestorationResponse?> res = await Services.instance.snapEdit.restoreImage(body);
      if (res.data != null) {
        final imageBase64 = res.data!.outputImage.image;
        final imageBytes = base64.decode(res.data!.outputImage.image);
        await _state.setImage(
          imageBytes, 
          imageBase64, 
          imageId: res.data!.imageId, 
          outputImageId: res.data!.outputImage.imageId,
        );

        /// SHOW GUIDE
        showEnhanceGuide();

        return true;
      }

      if (!res.status) {
        WidgetUtils.instance.showWarningPopup(
          title: S.of(context).restore, 
          message: S.of(context).unableToRestoreTheImagePleaseTryAgain, 
          retry: (_) => restoreImage(context),
        );
        Debug.log('===== ENAHNCE IMAGE ${res.message} =====');
      }

      return false;
    } finally {
      LoadingPopup.hide();
    }
  }

   @override
  Future<bool> videoEffect(BuildContext context) async {
    /// MAKED VIDEO
    if(_state.videoURL != null) return true;

    /// CHECKING RESTORED IMAGE
    if(_state.imageId == null || _state.outputImageId == null) return false;

    /// CHECKING ENVIROMENT
    final result = await checkEnviroment(context, retry: (_) => videoEffect(context));
    if (!result) return false;

    /// SHOW LOADING POPUP
    LoadingPopup.show();

    try {
      /// SHOW ADS
      adProvider.handleAd();

      /// CALL API
      GenerateVideoBody body = GenerateVideoBody(
        outputImageId: _state.outputImageId!,
        imageId: _state.imageId!,
      );

      SnapEditResponse<GenerateVideoResponse?> res = await Services.instance.snapEdit.generateVideo(body);

      if (res.data != null) {
        _state.videoURL = res.data!.outputVideoUrl;
        await Future.delayed(const Duration(milliseconds: 500));
        return true;
      }

      if (!res.status) {
        WidgetUtils.instance.showWarningPopup(
          title: S.of(context).videoEffect, 
          message: S.of(context).creatingVideoEffectsFailedPleaseTryAgain, 
          retry: (_) => videoEffect(context),
        );
        Debug.log('====== RESTYLE IMAGE ${res.message} ======');
      }

      return false;
    } finally {
      LoadingPopup.hide();
    }
  }

  @override
  Future<bool> saveVideo(BuildContext context) async {
    if (!canSave) return false;
    return checkoutSaveImage(context, () async {

      final provider = ManagerProvider.of<GalleryProvider>();
      File? savedVideoFile;

      if (_state.videoURL != null) {
        /// SHOW LOADING
        LoadingPopup.show();
        try {
          /// SHOW ADS
          adProvider.handleAd();

          /// SAVE VIDEO
          savedVideoFile = await provider.saveVideo(_state.videoURL!);
        } finally {
          LoadingPopup.hide();
        }
      }

      if (savedVideoFile != null) {
        /// SHOW SAVED VIDEO
        await showDialog<bool>(
          context: context,
          builder: (_) => SavedVideoPreview(
            editedImage: editedImage,
            videoURL: _state.videoURL!,
            savedFile: savedVideoFile!,
            onShare: () => Share.shareXFiles(
              [XFile(savedVideoFile!.path)],
              subject: Configuration.instance.business.shareApp.message,
            ),
            onNewImage: () {
              Navigator.of(context).popUntil((_) => _.settings.name == AppRoutes.albumsPage);
            },
          ),
        );
        return true;
      }

      /// SHOW ALERT
      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).saveVideo, 
        message: S.of(context).unableToSaveVideoPleaseTryAgain, 
        retry: save,
      );
      return false;
    }, () {
      /// MAX COUNT DOWNLOAD IMAGE
      /// SHOW ALERT

      WidgetUtils.instance.showWarningPopup(
        title: S.of(context).saveImageLimit,
        message: '${S.of(context).youHaveReachedTheLimitOfSavedImagePleaseUpgrade} ${Configuration.instance.business.appName} ${S.of(context).teamToSupport}',
        retry: save,
      );
    });
  }

  @override
  Future<bool> save(BuildContext context) {
    // Video tạm ẩn — luôn save ảnh
    // if (_tabController.page != null && _tabController.page! > 0.5) {
    //   return saveVideo(context);
    // }
    return super.save(context);
  }


  @override
  bool showEnhanceGuide() {
    int? num = AsyncStorage.instance.getInt(AsyncStorageKey.instance.enhanceGuide);
    if (num != null && num > 1) return false;

    WidgetUtils.instance.showDialog(builder: (_) => const EnhanceGuide());
    AsyncStorage.instance.setInt(AsyncStorageKey.instance.enhanceGuide, num == null ? 1 : num + 1);
    return true;
  }


  @override
  Future<bool> refresh(BuildContext context) async {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _state = RestoreState();
    _state.addListener(notifyListeners);
    return super.refresh(context);
  }

  @override
  void dispose() {
    _state.removeListener(notifyListeners);
    _state.dispose();
    _tabController.removeListener(notifyListeners);
    _tabController.dispose();
    _paintBefore.removeListener(notifyListeners);
    _paintBefore.dispose();
    super.dispose();
  }
}
