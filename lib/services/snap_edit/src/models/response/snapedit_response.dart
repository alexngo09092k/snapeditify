// ignore_for_file: public_member_api_docs, sort_constructors_first
class SnapEditResponse<T> {
  bool status;
  String? message;

  T? data;

  SnapEditResponse({
    this.status = false,
    this.message,
    this.data,
  });
}
