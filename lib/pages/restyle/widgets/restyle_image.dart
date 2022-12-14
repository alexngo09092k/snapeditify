import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/providers/restyle/restyle_provider.dart';
import 'package:snapedit/widgets/painter/painter_pure.dart';

class RestyleImage extends StatelessWidget {
  const RestyleImage({Key? key, required this.provider}) : super(key: key);
  final RestyleProvider provider;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 1.7 / 3;
    final double width = MediaQuery.of(context).size.width - AppDimensions.instance.padding * 2;
    final double iconSize = AppDimensions.instance.icon;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          /// PAINT
          Center(
            child: AspectRatio(
              aspectRatio: (provider.imageUI.width / provider.imageUI.height),
              child: BasePropConsumer<RestyleProvider, PainterController>(
                listenable: provider,
                select: (p) => p.state.paint,
                builder: (_, __, p, ___) => FlutterPainter(controller: p.state.paint),
              ),
            ),
          ),

          /// COMPARE BUTTON
          Positioned(
            right: AppDimensions.instance.padding,
            bottom: AppDimensions.instance.padding,
            child: GestureDetector(
              onTapDown: (_) => provider.compare(),
              onTapUp: (_) => provider.compare(),
              child: BasePropConsumer<RestyleProvider, bool>(
                listenable: provider,
                select: (p) => p.canCompare,
                builder: (_, __, p, ___) => Image.asset(
                  AppAssets.instance.icAdd,
                  color: p.canCompare ? AppColors.instance.blue : AppColors.instance.black,
                  width: iconSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
