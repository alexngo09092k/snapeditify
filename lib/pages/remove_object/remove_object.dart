import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/remove_object/widgets/image_paint.dart';
import 'package:snapedit/pages/remove_object/widgets/paint_control.dart';
import 'package:snapedit/pages/remove_object/widgets/revert_popup.dart';
import 'package:snapedit/pages/remove_object/widgets/saved_image_button.dart';
import 'package:snapedit/providers/remove_object_provider/remove_object_provider.dart';
import 'package:snapedit/common/extensions.dart';

class RemoveObjectPage extends StatefulWidget {
  const RemoveObjectPage({Key? key}) : super(key: key);


  @override
  State<RemoveObjectPage> createState() => _RemoveObjectPageState();
}

class _RemoveObjectPageState extends ProviderState<RemoveObjectPage, RemoveObjectProvider> {
  @override
  void initState() {
    super.initState();
    UserPermission.instance.requestStoragePermission(context: context);
    // provider.setImage(widget.imagePath);
  }

  Future<void> showRevertDialog() async {
    if (provider.prevPainterState != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => RevertPopup(
          onRevert: provider.revert,
        ),
      );
    }
    return;
  }

  Future<void> goBack() async {
    if (!provider.canBack) {
      // showAlert(
      //   context,
      //   buttons: [
      //     AwesomeAlertButton(
      //       name: S.of(context).cancel,
      //       action: Navigator.of(context).pop,
      //       color: Theme.of(context).textTheme.bodyText1!.color!,
      //     ),
      //     AwesomeAlertButton(
      //       name: S.of(context).ok,
      //       action: (_) {
      //         Navigator.of(context).popUntil((route) => route.isFirst);
      //       },
      //       color: Theme.of(context).textTheme.bodyText1!.color!,
      //     )
      //   ],
      //   content: Text(
      //     S.of(context).allChangesWillBeLostAreYouSureYouWant,
      //     style: Theme.of(context).textTheme.bodyText1,
      //   ),
      //   title: "",
      // );
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    provider.refresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.instance.kWhite,
        leading: IconButton(
          icon: Image.asset(
            AppAssets.instance.icBackNormal3x,
            width: 25,
          ),
          onPressed: goBack,
        ),
        title: Center(
          child: PropConsumer<RemoveObjectProvider, bool>(
            select: (p) => p.prevPainterState != null,
            builder: (_, __, p, ___) => IconButton(
              icon: Image.asset(
                AppAssets.instance.icRevertNormal3x,
                width: 20,
              ),
              onPressed: p.prevPainterState != null ? showRevertDialog : null,
            ),
          ),
        ),
        actions: const [SavedImageButton()],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ImagePaint(),
            PaintControl(key: provider.painterControlKey),
          ],
        ),
      ),
    );
  }
}
