// ignore_for_file: public_member_api_docs, sort_constructors_first
class SnapEditResponse<T> {
  String? error;
  String? message;

  T? data;

  SnapEditResponse({
    this.error,
    this.message,
    this.data,
  });
}
