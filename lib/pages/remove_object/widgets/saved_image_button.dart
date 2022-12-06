import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:fluttering_ads/fluttering_ads.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/pages/remove_object/widgets/saved_image_view.dart';
import 'package:snapedit/common/extensions.dart';
import 'package:snapedit/providers/remove_object_provider/remove_object_provider.dart';
import 'package:snapedit/providers/remove_object_provider/painter_state.dart';

class SavedImageButton extends StatelessWidget {
  const SavedImageButton({Key? key}) : super(key: key);

  Future<void> saveAndShowImage(context) async {
    ManagerProvider.of<AwesomeAdvertisement>().showAd();
    UserPermission.instance.requestStoragePermission(
      context: context,
      onHasPermisson: () {
        RemoveObjectProvider p = ManagerProvider.of<RemoveObjectProvider>();
        p.saveImage((savedImagePath, originalImageBase64) {
          showModalBottomSheet(
            context: context,
            builder: (_) => SavedImageView(
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
    return PropConsumer<RemoveObjectProvider, PainterState?>(
      select: (p) => p.state.prevState,
      builder: (_, __, p, ___) => TextButton(
        onPressed: p.state.prevState != null ? () => saveAndShowImage(context) : null,
        child: Text(
          S.of(context).save,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: p.state.prevState != null ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
              ),
        ),
      ),
    );
  }
}
