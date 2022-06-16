import 'package:flutter/material.dart';
import 'package:snapretouch/common/app_routes.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/generated/l10n.dart';
import 'package:snapretouch/modules/advertisement/models/advertisement_view.dart';
import 'package:snapretouch/pages/edit/widgets/saved_image_view.dart';
import 'package:snapretouch/services/services.dart';
import 'package:snapretouch/utils/permission_checking.dart';

class SavedImageButton extends StatelessWidget {
  const SavedImageButton({Key? key, required this.controller})
      : super(key: key);
  final EditController controller;

  Future<void> saveAndShowImage(context) async {
    Services().advertisement.loadAd(
          type: AdvertisementViewType.handle,
          onAd: (handleAd) {
            if (handleAd != null) {
              handleAd.show();
            }
          },
          screenName: AppRoutes.edit,
        );
    PermissionChecking.requestStorePermission(
      context: context,
      onHasPermisson: () {
        controller.saveImage((savedImagePath, originalImageBase64) {
          showModalBottomSheet(
            context: context,
            builder: (_) => SavedImageView(
              controller: controller,
              imagePath: savedImagePath,
              originalImageBase64: originalImageBase64,
            ),
            isDismissible: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, __, ___) => TextButton(
        onPressed: controller.state.prevState != null
            ? () => saveAndShowImage(context)
            : null,
        child: Text(
          S.of(context).save,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: controller.state.prevState != null
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
              ),
        ),
      ),
    );
  }
}
