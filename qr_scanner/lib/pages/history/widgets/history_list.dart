import 'package:flutter/material.dart';
import 'package:fluttering/fluttering.dart';
import 'package:qr_scanner/common/constants.dart';
import 'package:qr_scanner/models/qr_data.dart';
import 'package:qr_scanner/models/qr_data_type.dart';
import 'package:qr_scanner/pages/history/widgets/history_item.dart';
import 'package:qr_scanner/providers/history_provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class HistoryList extends StatelessWidget {
  const HistoryList(this.type, {super.key});
  final QRDataType type;

  Widget _getGroupSeparator(BuildContext context, QRData element) {
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
    return PropConsumer<HistoryProvider, List<QRData>>(
      select: (_) => (type == QRDataType.isGenerated ? _.generateHistory : _.scanHistory),
      builder: (_, __, ___, list) => SizedBox(
        height: 400,
        width: 400,
        child: StickyGroupedListView<QRData, DateTime>(
          elements: list,
          order: StickyGroupedListOrder.ASC,
          groupBy: (QRData element) => DateTime(
            element.lastModified.year,
            element.lastModified.month,
            element.lastModified.day,
          ),
          groupComparator: (DateTime value1, DateTime value2) => value2.compareTo(value1),
          itemComparator: (QRData element1, QRData element2) => element1.lastModified.compareTo(element2.lastModified),
          floatingHeader: true,
          groupSeparatorBuilder:(_) => _getGroupSeparator(context, _),
          itemBuilder: (_, qrData) => HistoryItem(qrData: qrData),
        ),
      ),
    );
  }
}
