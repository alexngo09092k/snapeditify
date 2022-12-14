import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/pages/remove_object/widgets/ai_mode_result.dart';
import 'package:snapedit/pages/remove_object/widgets/brush_mode_setting.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/providers/remove_object/remove_object_state.dart';
import 'package:snapedit/widgets/ai_icon.dart';

class RemoveObjectControl extends StatelessWidget {
  const RemoveObjectControl({super.key, required this.provider});
  final RemoveObjectProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BasePropConsumer<RemoveObjectProvider, RemoveObjectMode>(
        listenable: provider,
        select: (p) => p.state.mode,
        builder: (_, __, p, ___) => Column(
          children: [
            SizedBox(height: AppDimensions.instance.padding),

            /// BRUSH SETTING
            if (p.state.mode != RemoveObjectMode.ai) BrushModeSetting(provider: provider),

            /// DETECTED OBJECT LIST
            if (p.state.mode == RemoveObjectMode.ai) AIModeResult(provider: provider),

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
                          Image.asset(
                            AppAssets.instance.icFaceId,
                            width: AppDimensions.instance.icon,
                          ),
                          SizedBox(height: AppDimensions.instance.padding),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(S.of(context).auto),
                              SizedBox(width: AppDimensions.instance.paddingX(1)),
                              const AIIcon(),
                            ],
                          )
                        ],
                      ),
                    ),

                    /// BURSH BUTTON
                    GestureDetector(
                      onTap: () => provider.toBrush(context),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.instance.icBrush,
                            width: AppDimensions.instance.icon,
                            color: p.state.mode == RemoveObjectMode.brush ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          ),
                          SizedBox(height: AppDimensions.instance.padding),
                          Text(
                            S.of(context).brush,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: p.state.mode == RemoveObjectMode.brush ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
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
