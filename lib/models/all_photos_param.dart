// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllPhotosParam {
  AllPhotosAction action;

  AllPhotosParam({
    required this.action,
  });
}

enum AllPhotosAction {
  removeObject,
  enhanceImage,
  applyArtEffect,
}
