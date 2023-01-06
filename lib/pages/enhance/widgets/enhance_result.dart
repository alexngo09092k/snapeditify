import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/enhance/widgets/enhance_face_list.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';
import 'package:snapedit/widgets/base/sliding_control.dart';

class EnhanceResult extends StatefulWidget {
  const EnhanceResult({super.key, required this.provider});
  final EnhanceProvider provider;

  @override
  State<EnhanceResult> createState() => _EnhanceResultState();
}

class _EnhanceResultState extends State<EnhanceResult> {
  @override
  void initState() {
    super.initState();
  }

  void _onChangedResult(int? index) {
    if (index == null) return;
    widget.provider.state.enhancedImages[index].onSelect();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Enhance results', style: Theme.of(context).textTheme.bodyText1),
              const Expanded(flex: 1, child: SizedBox()),
              BasePropConsumer<EnhanceProvider, int>(
                listenable: widget.provider,
                select: (p) => p.state.enhancedImages.length,
                builder: (_, __, p, ___) => p.state.enhancedImages.isNotEmpty
                    ? SlidingControl<int>.defaultStyle(
                        context,
                        value: 0,
                        data: {
                          1: 'Result 1',
                          2: 'Result 2',
                          3: 'Result 3',
                          ...p.state.enhancedImages.asMap().map(
                                (_, value) => MapEntry(value.index, 'Result ${value.index}'),
                              )
                        },
                        onValueChanged: _onChangedResult,
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        EnhanceFaceList(provider: widget.provider),
      ],
    );
  }
}
