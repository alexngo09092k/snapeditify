import 'package:flutter/material.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/pages/enhance/widgets/enhance_face_list.dart';
import 'package:snapedit/providers/enhance/enhance_provider.dart';

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

  void _onChangedResult(String? image) {}

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
            children: const [
              Text('Enhance results'),
              Expanded(flex: 1, child: SizedBox()),
              // BasePropConsumer<EnhanceProvider, int>(
              //   listenable: widget.provider,
              //   select: (p) => p.state.enhancedImages.length,
              //   builder: (_, __, p, ___) => p.state.enhancedImages.isNotEmpty
              //       ? SlidingControl<int>.defaultStyle(
              //           context,
              //           value: 0,
              //           data: const {
              //             1: 'Result 1',
              //             2: 'Result 2',
              //             3: 'Result 3',
              //           },
              //           onValueChanged: (_) {},
              //         )
              //       : const SizedBox(),
              // ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.instance.padding),
        EnhanceFaceList(provider: widget.provider),
      ],
    );
  }
}
