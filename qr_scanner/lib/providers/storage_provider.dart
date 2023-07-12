abstract class StorageProvider {
  void syncFromStorage([bool notify = false]);

  Future<void> syncFromServer([bool notify = false]);

  Future<void> syncToStorage([bool notify = false]);

  Future<bool> cleanToStorage([bool notify = false]);

  void clean([bool notify = false]);
}
