import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';

class RemoveObjectRevert extends StatelessWidget {
  const RemoveObjectRevert({super.key, required this.provider});
  final RemoveObjectProvider provider;

  _revert() {
    /// SHOW DIALOG
    provider.revert();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _revert,
        child: BasePropConsumer<RemoveObjectProvider, bool>(
          listenable: provider,
          select: (p) => p.canRevert,
          builder: (_, __, p, ___) => Image.asset(
            AppAssets.instance.icAdd,
            width: 20,
          ),
        ),
      ),
    );
  }
}

/// DEFINED REVERT POPUP
class _RevertPopup extends StatelessWidget {
  const _RevertPopup();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
