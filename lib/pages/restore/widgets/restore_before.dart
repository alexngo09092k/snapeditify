import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/widgets/app_use/painter/painter_pure.dart';

class RestoreBefore extends StatelessWidget {
  const RestoreBefore({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PropConsumer<IRestoreProvider, PainterController>(
        child: Positioned(
          left: AppDimensions.instance.padding,
          top: AppDimensions.instance.padding,
          child: Text(
            S.of(context).before,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.instance.white,
                ),
          ),
        ),
        select: (p) => p.paintBefore,
        builder: (_, child, p, paint) => AspectRatio(
          aspectRatio: p.originalImage.ratio,
          child: Stack(
            children: [
              FlutterPainter(controller: paint),
              child ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
