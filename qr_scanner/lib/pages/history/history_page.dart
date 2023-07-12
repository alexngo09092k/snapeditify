import 'package:flutter/material.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_data_type.dart';
import 'package:qr_scanner/pages/history/widgets/history_list.dart';
import 'package:qr_scanner/pages/history/widgets/history_tab.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ValueNotifier<QRDataType> _tab = ValueNotifier(QRDataType.isScanned);
  late final PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _tab.value.index);
    _controller.addListener(() {
      if (_controller.page == null) return;
      if (_tab.value.index != _controller.page!.round()) {
        _tab.value = QRDataType.values[_controller.page!.round()];
      }
    });
    super.initState();
  }

  void _onChanged(tab) {
    _tab.value = tab;
    _controller.animateToPage(tab.index, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            HistoryTab(
              tab:_tab,
              onChanged: _onChanged,
            ),
            SizedBox(height: AppDimensions.instance.padding),
            Expanded(
              child: PageView(
                controller: _controller,
                children: QRDataType.values.map((e) => HistoryList(e)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
