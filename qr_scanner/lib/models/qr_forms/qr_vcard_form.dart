// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:qr_scanner/models/qr_forms/qr_form_base.dart';
import 'package:qr_scanner/utils/qr.dart';

class QRVCardForm extends QRFormBase {
  String lastName;
  String firstName;
  String company;
  String job;
  String street;
  String city;
  String state;
  int zip;
  String country;
  String phone;
  String mobile;
  String fax;
  String email;
  String website;

  QRVCardForm({
    this.lastName = "",
    this.firstName = "",
    this.company = "",
    this.job = "",
    this.street = "",
    this.city = "",
    this.state = "",
    this.zip = 0,
    this.country = "",
    this.phone = "",
    this.mobile = "",
    this.fax = "",
    this.email = "",
    this.website = "",
  });

  @override
  String? buildQRRawData() {
    if (!validate()) return null;
    return "BEGIN:VCARD\nVERSION:3.0\nN:$lastName;$firstName\nFN:$firstName $lastName\nORG:$company\nTITLE:$job\nADR:;;$street;$city;$state;$zip;$country\nTEL;WORK;VOICE:$phone\nTEL;CELL:$mobile\nTEL;FAX:$fax\nEMAIL;WORK;INTERNET:$email\nURL:$website\nEND:VCARD";
  }

  @override
  bool validate() {
    return lastName.isNotEmpty &&
        firstName.isNotEmpty &&
        street.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        (phone.isEmpty || QRUtils.instance.isPhoneNumber(phone)) &&
        (mobile.isEmpty || QRUtils.instance.isPhoneNumber(mobile)) &&
        (email.isEmpty || QRUtils.instance.isEmail(email) &&
        (website.isEmpty || QRUtils.instance.isURL(website)));
  }

  static bool isQR(String rawData) {
    final check = rawData.toLowerCase().trim();
    final List<String> checkList = [
      'begin:vcard',
    ];
    return checkList.any((element) => check.startsWith(element));
  }
}
