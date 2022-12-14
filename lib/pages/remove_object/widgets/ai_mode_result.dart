import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapedit/common/constants.dart';
import 'package:snapedit/generated/l10n.dart';
import 'package:snapedit/models/ai_detection_handler.dart';
import 'package:snapedit/pages/remove_object/widgets/detected_object_list.dart';
import 'package:snapedit/providers/remove_object/remove_object_provider.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';
import 'package:snapedit/widgets/base/sliding_control.dart';

class AIModeResult extends StatefulWidget {
  const AIModeResult({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  @override
  State<AIModeResult> createState() => _AIModeResultState();
}

class _AIModeResultState extends State<AIModeResult> {
  int _indexTab = 0;

  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _indexTab);
    super.initState();
  }

  _onChangedTab(DetectedObjectType type) {
    switch (type) {
      case DetectedObjectType.person:
        _indexTab = 0;
        break;
      case DetectedObjectType.other:
        _indexTab = 1;
        break;
      default:
    }
    _controller.animateToPage(
      _indexTab,
      duration: const Duration(),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.instance.paddingX(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => widget.provider.toBrush(context),
                      child: Image.asset(AppAssets.instance.icAdd, width: 25),
                    ),
                    SizedBox(width: AppDimensions.instance.paddingX(1)),
                    BasePropConsumer<RemoveObjectProvider, int>(
                      listenable: widget.provider,
                      select: (p) => p.state.detectedObjects.values.length,
                      builder: (_, __, p, ___) => Text(
                        '${p.state.detectedObjects.values.length} ${S.of(context).objects}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
                const Expanded(flex: 1, child: SizedBox()),
                SlidingControl<DetectedObjectType>.defaultStyle(
                  context,
                  value: DetectedObjectType.person,
                  data: DetectedObjectType.values.asMap().map((_, type) => MapEntry(type, type.label)),
                  onValueChanged: _onChangedTab,
                ),
              ],
            ),
          ),
          SizedBox(height: AppDimensions.instance.padding),
          Expanded(
            child: PageView(
              controller: _controller,
              children: DetectedObjectType.values
                  .map<Widget>((type) => DetectedObjectList(
                        type: type,
                        provider: widget.provider,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
