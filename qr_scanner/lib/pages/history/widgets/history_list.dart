import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr.dart';
import 'package:qr_scanner/models/qr_source.dart';
import 'package:qr_scanner/pages/history/widgets/history_item.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class HistoryList extends StatefulWidget {
  const HistoryList(this.type, {super.key});
  final QRSource type;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final GroupedItemScrollController itemScrollController = GroupedItemScrollController();

  Widget _getGroupSeparator(BuildContext context, QR element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.instance.padding),
          child: Text(
            '${element.lastModified.day} - ${element.lastModified.month} - ${element.lastModified.year}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropConsumer<HistoryProvider, List<QR>>(
      select: (_) => (widget.type == QRSource.generate ? _.generateHistory : _.scanHistory),
      builder: (_, __, ___, list) => StickyGroupedListView<QR, DateTime>(
        elements: list,
        itemScrollController: itemScrollController,
        order: StickyGroupedListOrder.ASC,
        padding: const EdgeInsets.only(bottom: 100),
        groupBy: (QR element) => DateTime(
          element.lastModified.year,
          element.lastModified.month,
          element.lastModified.day,
        ),
        groupComparator: (DateTime value1, DateTime value2) => value2.compareTo(value1),
        itemComparator: (QR element1, QR element2) => element2.lastModified.compareTo(element1.lastModified),
        floatingHeader: true,
        groupSeparatorBuilder:(_) => _getGroupSeparator(context, _),
        itemBuilder: (_, qr) => HistoryItem(qr: qr),
      ),
    );
  }
}
