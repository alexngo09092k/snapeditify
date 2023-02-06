import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/generated/l10n.dart';
import 'package:snapeditify/view_models/detected_object_vm.dart';
import 'package:snapeditify/pages/remove_object/widgets/detected_object_list.dart';
import 'package:snapeditify/providers/remove_object/remove_object_provider.dart';
import 'package:snapeditify/services/snap_edit/snap_edit.dart';
import 'package:snapeditify/widgets/base/custom_icon.dart';
import 'package:snapeditify/widgets/base/sliding_control.dart';

class AIModeResult extends StatefulWidget {
  const AIModeResult({Key? key}) : super(key: key);

  @override
  State<AIModeResult> createState() => _AIModeResultState();
}

class _AIModeResultState extends ProviderStateObserver<AIModeResult, RemoveObjectProvider> {
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

  @override
  void onNextFrame(Duration timestamp) {
    final detectedObjects = provider.state.detectedObjects;
    final bool hasPersonObject = detectedObjects.values.any((element) => element.objectType == DetectedObjectType.person);
    if (!hasPersonObject && detectedObjects.isNotEmpty) {
      _controller.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
    super.onNextFrame(timestamp);
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
    _controller.animateToPage(_indexTab.value, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
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
                      onTap: () => provider.toBrush(context),
                      child: const CustomIcon(CupertinoIcons.back),
                    ),
                    BasePropConsumer<RemoveObjectProvider, int>(
                      listenable: provider,
                      select: (p) => p.state.detectedObjects.length,
                      builder: (_, __, ___, count) => Text(
                        '$count ${S.of(context).objects}',
                        style: Theme.of(context).textTheme.titleSmall,
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
                        provider: provider,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
