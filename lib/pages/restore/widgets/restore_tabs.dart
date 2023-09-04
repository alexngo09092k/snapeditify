import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/common/constants.dart';
import 'package:snapeditify/pages/restore/widgets/restore_image.dart';
import 'package:snapeditify/pages/restore/widgets/restore_video.dart';
import 'package:snapeditify/providers/restore/restore_provider.dart';
import 'package:snapeditify/widgets/base/sliding_control.dart';

class RestoreTabs extends StatefulWidget {
  const RestoreTabs({Key? key}) : super(key: key);

  @override
  State<RestoreTabs> createState() => _RestoreTabsState();
}

class _RestoreTabsState extends ProviderStateObserver<RestoreTabs, RestoreProvider> {
  final ValueNotifier<int> _indexTab = ValueNotifier(0);

  PageController get controller => provider.tabController;

  @override
  void initState() {
    super.initState();
    controller.addListener(_listenChange);
  }

  _listenChange() {
    if (controller.page == null) return;
    if (_indexTab.value != controller.page!.round()) {
      _indexTab.value = controller.page!.round();
    }
  }

  void _onChangedTab(int? index) {
    if (index == null) return;
    _indexTab.value = index;
    controller.animateToPage(
      _indexTab.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.removeListener(_listenChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: const [
                RestoreImage(),
                RestoreVideo(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppDimensions.instance.padding),
            child: AnimatedBuilder(
              animation: _indexTab,
              builder: (_, __) => SlidingControl<int>.defaultStyle(
                context,
                value: [0, 1].elementAt(_indexTab.value),
                data: const {
                  0: 'Image Only',
                  1: 'Video Effect',
                },
                onValueChanged: _onChangedTab,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
