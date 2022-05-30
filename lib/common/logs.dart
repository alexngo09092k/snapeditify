
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

void printLog([dynamic data, DateTime? startTime]) {
  if (kDebugMode) {
    var time = '';
    if (startTime != null) {
      final endTime = DateTime.now().difference(startTime);
      final icon = endTime.inMilliseconds > 2000
          ? '⌛️ Slow-'
          : endTime.inMilliseconds > 1000
              ? '⏰ Medium-'
              : '⚡️ Fast-';
      time = '[$icon${endTime.inMilliseconds}ms]';
    }

    try {
      final now = DateFormat('h:mm:ss-ms').format(DateTime.now());
      debugPrint('ℹ️ [${now}ms]$time${data.toString()}');

      if (data.toString().contains('is not a subtype of type')) {
        throw Exception();
      }
    } catch (e, trace) {
      debugPrint('🔴 ${data.toString()}');
      debugPrint(trace.toString());
    }
  }
}
