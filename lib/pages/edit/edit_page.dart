import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/pages/edit/widgets/image_paint.dart';
import 'package:snapedit/pages/edit/widgets/paint_control.dart';
import 'package:snapedit/pages/edit/widgets/revert_popup.dart';
import 'package:snapedit/pages/edit/widgets/saved_image_button.dart';
import 'package:snapedit/utils/permission_checking.dart';
import 'package:snapedit/widgets/custom_overlay_state.dart';
import 'package:snapedit/widgets/go_back_popup.dart';

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
    PermissionChecking.requestStorePermission(context);
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
        builder: (_) => const GoBackPopup(),
      );
      return;
    }
    Navigator.of(context).pop();
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
        leading: IconButton(
          icon: Image.asset(
            AppImages.icBackNormal3x,
            width: 30,
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
              onPressed: _controller.prevPainterState != null ? showRevertDialog : null,
            ),
          ),
        ),
        actions: [SavedImageButton(controller: _controller)],
      ),
      body: Column(
        children: [
          ImagePaint(
            controller: _controller,
          ),
          PaintControl(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
