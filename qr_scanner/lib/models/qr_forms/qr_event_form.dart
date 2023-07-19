// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';

class QREventForm extends QRFormBase {
  String title;
  String location;
  DateTime start;
  DateTime end;

  QREventForm({
    this.title = "",
    this.location = "",
    required this.start,
    required this.end,
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "BEGIN:VEVENT\nSUMMARY:$title\nLOCATION:$location\nDTSTART:$start\nDTEND:$end\nEND:VEVENT\n";
  }

  @override
  bool validate() {
    return title.isNotEmpty && location.isNotEmpty;
  }
}