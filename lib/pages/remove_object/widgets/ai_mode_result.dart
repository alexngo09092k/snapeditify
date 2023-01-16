import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:phosart/common/constants.dart';
import 'package:phosart/view_models/detected_object_vm.dart';
import 'package:phosart/pages/remove_object/widgets/detected_object_list.dart';
import 'package:phosart/providers/remove_object/remove_object_provider.dart';
import 'package:phosart/services/snap_edit/snap_edit.dart';
import 'package:phosart/widgets/base/custom_icon.dart';
import 'package:phosart/widgets/base/sliding_control.dart';

class AIModeResult extends StatefulWidget {
  const AIModeResult({Key? key, required this.provider}) : super(key: key);
  final RemoveObjectProvider provider;

  @override
  State<AIModeResult> createState() => _AIModeResultState();
}

class _AIModeResultState extends State<AIModeResult> {
  final ValueNotifier<int> _indexTab = ValueNotifier(0);

  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _indexTab.value);
    _controller.addListener(() {
      if (_controller.page == null) return;
      if (_indexTab.value != _controller.page!.round()) {
        _indexTab.value = _controller.page!.round();
      }
    });
    super.initState();
  }

  void _onChangedTab(DetectedObjectType? type) {
    if (type == null) return;
    switch (type) {
      case DetectedObjectType.person:
        _indexTab.value = 0;
        break;
      case DetectedObjectType.other:
        _indexTab.value = 1;
        break;
      default:
    }
    _controller.animateToPage(
      _indexTab.value,
      duration: const Duration(milliseconds: 200),
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
                    GestureDetector(
                      onTap: () => widget.provider.toBrush(context),
                      child: CustomIcon(
                        AppAssets.instance.icArrowLeft,
                        size: AppDimensions.instance.iconX(0.5),
                      ),
                    ),
                    SizedBox(width: AppDimensions.instance.paddingX(0.5)),
                    BasePropConsumer<RemoveObjectProvider, int>(
                      listenable: widget.provider,
                      select: (p) => p.state.detectedObjects.length,
                      builder: (_, __, p, ___) => Text(
                        '${p.state.detectedObjects.length} Objects',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
                const Expanded(flex: 1, child: SizedBox()),
                AnimatedBuilder(
                  animation: _indexTab,
                  builder: (_, __) => SlidingControl<DetectedObjectType>.defaultStyle(
                    context,
                    value: DetectedObjectType.values.elementAt(_indexTab.value),
                    data: DetectedObjectType.values.asMap().map((_, type) => MapEntry(type, type.label)),
                    onValueChanged: _onChangedTab,
                  ),
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
