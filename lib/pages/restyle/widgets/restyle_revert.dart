import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';

class RestyleRevert extends StatelessWidget {
  const RestyleRevert({super.key, required this.provider});
  final RestyleProvider provider;

  _revert() {
    /// SHOW DIALOG
    // provider.revert();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _revert,
        child: BasePropConsumer<RestyleProvider, bool>(
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
