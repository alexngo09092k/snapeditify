// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QREmailForm extends QRFormBase {
  String email;
  String subject;
  String message;

  QREmailForm({
    this.email = "",
    this.subject = "",
    this.message = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "MATMSG:TO:$email;SUB:$subject;BODY:$message;;";
  }

  @override
  bool validate() {
    return QRUtils.instance.isEmail(email) && message.isNotEmpty;
  }
}