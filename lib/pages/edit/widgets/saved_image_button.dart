import 'package:flutter/material.dart';
import 'package:snapedit/controllers/edit/edit_controller.dart';
import 'package:snapedit/pages/edit/widgets/saved_image_view.dart';

class SavedImageButton extends StatelessWidget {
  const SavedImageButton({Key? key, required this.controller})
      : super(key: key);
  final EditController controller;

  Future<void> saveAndShowImage(context) async {
    await controller.saveImage((savedImagePath) {
      Scaffold.of(context).showBottomSheet(
        (BuildContext context) {
          return SavedImageView(
            controller: controller,
            image: savedImagePath,
          );
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, __, ___) => TextButton(
        child: Text(
          'Save',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: controller.state.prevImage != null
                    ? Theme.of(context).textTheme.bodyLarge!.color
                    : Theme.of(context).disabledColor,
              ),
        ),
        onPressed: controller.state.prevImage != null
            ? () => saveAndShowImage(context)
            : null,
      ),
    );
  }
}
