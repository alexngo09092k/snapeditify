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

  void _onChangedResult(String image) {
    Debug.log(widget.provider.state.enhancedImageUIList[image]);
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
              const Text('Enhance results'),
              const Expanded(flex: 1, child: SizedBox()),
              BasePropConsumer<EnhanceProvider, int>(
                listenable: widget.provider,
                select: (p) => p.state.enhancedImageBase64List.length,
                builder: (_, __, p, ___) => p.state.enhancedImageBase64List.isNotEmpty
                    ? SlidingControl<String>.defaultStyle(
                        context,
                        value: p.state.enhancedImageBase64List.first,
                        data: {
                          ...p.state.enhancedImageBase64List.asMap().map((_, value) => MapEntry(value, 'Result $_')),
                          '': 'Result 2',
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
