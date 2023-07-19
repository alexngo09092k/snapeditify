import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/pages/history/widgets/history_list.dart';
import 'package:qr_scanner/pages/history/widgets/history_tab.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:qr_scanner/widgets/app_use/app_layout.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState
    extends ProviderStateObserver<HistoryPage, HistoryProvider> {
  final ValueNotifier<QRSource> _tab = ValueNotifier(QRSource.isScanned);
  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _tab.value.index);
    _controller.addListener(() {
      if (_controller.page == null) return;
      if (_tab.value.index != _controller.page!.round()) {
        _tab.value = QRSource.values[_controller.page!.round()];
      }
    });
    super.initState();
  }

  @override
  void onNextFrame(Duration timestamp) {
    if (provider.scanHistory.isEmpty && provider.generateHistory.isNotEmpty) {
      _onChanged(QRSource.isGenerated);
    }
    super.onNextFrame(timestamp);
  }

  void _onChanged(tab) {
    _tab.value = tab;
    _controller.animateToPage(tab.index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      screen: "History",
      appBar: true,
      back: false,
      children: [
        HistoryTab(
          tab: _tab,
          onChanged: _onChanged,
        ),
        SizedBox(height: AppDimensions.instance.padding),
        Expanded(
          child: PageView(
            controller: _controller,
            children: QRSource.values.map((e) => HistoryList(e)).toList(),
          ),
        )
      ],
    );
  }
}
