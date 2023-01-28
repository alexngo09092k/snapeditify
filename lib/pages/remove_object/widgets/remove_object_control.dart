import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/remove_object/widgets/ai_mode_result.dart';
import 'package:snapeditify/pages/remove_object/widgets/brush_mode_setting.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/providers/remove_object/remove_object_state.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class RemoveObjectControl extends StatelessWidget {
  const RemoveObjectControl({super.key, required this.provider});
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      child: BasePropConsumer<RemoveObjectProvider, RemoveObjectMode>(
        listenable: provider,
        select: (p) => p.state.mode,
        builder: (_, __, p, ___) => Column(
          children: [
            SizedBox(height: AppDimensions.instance.padding),

            /// BRUSH SETTING
            if (p.state.mode != RemoveObjectMode.ai) BrushModeSetting(provider: provider),

            /// DETECTED OBJECT LIST
            if (p.state.mode == RemoveObjectMode.ai) const AIModeResult(),

            /// MODE BUTTONS
            if (p.state.mode != RemoveObjectMode.ai)
              Padding(
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// AI BUTTON
                    GestureDetector(
                      onTap: () => provider.toAI(context),
                      child: Column(
                        children: [
                          CustomIcon(AppAssets.instance.icAI),
                          SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                          Text(S.of(context).auto, style: Theme.of(context).textTheme.bodyText1),
                        ],
                      ),
                    ),

                    /// BRUSH BUTTON
                    GestureDetector(
                      onTap: () => provider.toBrush(context),
                      child: Column(
                        children: [
                          CustomIcon(
                            AppAssets.instance.icBrush,
                            color: p.state.mode != RemoveObjectMode.ai ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          ),
                          SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                          Text(
                            S.of(context).brush,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: p.state.mode != RemoveObjectMode.ai ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
