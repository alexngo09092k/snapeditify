import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/restore/widgets/restore_image.dart';
import 'package:snapeditify/pages/restore/widgets/restore_video.dart';
import 'package:snapeditify/widgets/base/sliding_control.dart';

class RestoreTabs extends StatefulWidget {
  const RestoreTabs({Key? key}) : super(key: key);

  @override
  State<RestoreTabs> createState() => _RestoreTabsState();
}

class _RestoreTabsState extends State<RestoreTabs> {
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

  void _onChangedTab(int? index) {
    if (index == null) return;
    _indexTab.value = index;
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
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                RestoreImage(),
                RestoreVideo(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.instance.paddingX(1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _indexTab,
                  builder: (_, __) => SlidingControl<int>.defaultStyle(
                    context,
                    value: [0, 1].elementAt(_indexTab.value),
                    data: const {
                      0: "Image Only",
                      1: "Video Effect",
                    },
                    onValueChanged: _onChangedTab,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
