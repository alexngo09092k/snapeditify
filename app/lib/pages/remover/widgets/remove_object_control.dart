import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/pages/remover/widgets/ai_mode_result.dart';
import 'package:snapeditify/pages/remover/widgets/brush_mode_setting.dart';
import 'package:snapeditify/providers/remover/remover_provider.dart';
import 'package:snapeditify/providers/remover/remover_state.dart';
import 'package:snapeditify/widgets/app_use/ai_icon.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';

class RemoveObjectControl extends StatelessWidget {
  const RemoveObjectControl({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AwesomeAppState.screen.height * 1.2 / 5,
      child: PropConsumer<IRemoverProvider, RemoveObjectMode>(
        select: (p) => p.state.mode,
        builder: (_, __, p, mode) => Column(
          children: [
            SizedBox(height: AppDimensions.instance.padding),

            /// BRUSH SETTING
            if (mode != RemoveObjectMode.ai) const BrushModeSetting(),

            /// DETECTED OBJECT LIST
            if (mode == RemoveObjectMode.ai) const AIModeResult(),

            /// MODE BUTTONS
            if (mode != RemoveObjectMode.ai)
              Padding(
                padding: EdgeInsets.all(AppDimensions.instance.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// AI BUTTON
                    GestureDetector(
                      onTap: () => p.toAI(context),
                      child: Column(
                        children: [
                          CustomIcon(AppAssets.instance.icAI),
                          SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${S.of(context).auto} ', style: Theme.of(context).textTheme.bodyLarge),
                              const AIIcon(),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// BRUSH BUTTON
                    GestureDetector(
                      onTap: () => p.toBrush(context),
                      child: Column(
                        children: [
                          CustomIcon(
                            AppAssets.instance.icBrush,
                            color: mode != RemoveObjectMode.ai ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          ),
                          SizedBox(height: AppDimensions.instance.paddingX(0.5)),
                          Text(
                            S.of(context).brush,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: mode != RemoveObjectMode.ai ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
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
