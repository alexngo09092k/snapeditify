import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';

class RemoveObjectSave extends StatelessWidget {
  const RemoveObjectSave({super.key, required this.provider});
  final RemoveObjectProvider provider;

  Future<void> saveAndShowImage(context) async {
    provider.saveImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => saveAndShowImage(context),
      child: PropConsumer<RemoveObjectProvider, bool>(
        select: (p) => p.canSave,
        builder: (_, __, p, ___) => Text(
          S.of(context).save,
        ),
      ),
    );
  }
}

class _EditedImagePopup extends StatelessWidget {
  const _EditedImagePopup();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
