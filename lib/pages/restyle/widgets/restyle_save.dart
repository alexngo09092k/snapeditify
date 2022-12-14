import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';

class RestyleSave extends StatelessWidget {
  const RestyleSave({super.key, required this.provider});
  final RestyleProvider provider;

  Future<void> saveAndShowImage(context) async {
    // provider.saveImage(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => saveAndShowImage(context),
      child: BasePropConsumer<RestyleProvider, bool>(
        listenable: provider,
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
