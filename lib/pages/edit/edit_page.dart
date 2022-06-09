import 'package:flutter/material.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/controllers/edit/edit_controller.dart';
import 'package:snapretouch/pages/edit/widgets/image_paint.dart';
import 'package:snapretouch/pages/edit/widgets/paint_control.dart';
import 'package:snapretouch/pages/edit/widgets/revert_popup.dart';
import 'package:snapretouch/pages/edit/widgets/saved_image_button.dart';
import 'package:snapretouch/utils/permission_checking.dart';
import 'package:snapretouch/widgets/custom_overlay_state.dart';
import 'package:snapretouch/widgets/go_back_popup.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends CustomOverlayState<EditPage> {
  late EditController _controller;

  @override
  void initState() {
    PermissionChecking.requestStorePermission(context: context);
    _controller = EditController(imagePath: widget.imagePath, context: context);
    super.initState();
  }

  Future<void> showRevertDialog() async {
    if (_controller.prevPainterState != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => RevertPopup(
          onRevert: _controller.revert,
        ),
      );
    }
    return;
  }

  Future<void> goBack() async {
    if (_controller.prevPainterState != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => GoBackPopup(
          onBack: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      );
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        leading: IconButton(
          icon: Image.asset(
            AppImages.icBackNormal3x,
            width: 25,
          ),
          onPressed: goBack,
        ),
        title: Center(
          child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (_, __, ___) => IconButton(
              icon: Image.asset(
                AppImages.icRevertNormal3x,
                width: 20,
              ),
              onPressed: _controller.prevPainterState != null
                  ? showRevertDialog
                  : null,
            ),
          ),
        ),
        actions: [SavedImageButton(controller: _controller)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ImagePaint(
              controller: _controller,
            ),
            PaintControl(
              key: _controller.painterControlKey,
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
