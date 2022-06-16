import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:snapretouch/common/logs.dart';

class AppCache {
  static final AppCache _instance = AppCache._internal();
  static AppCache get instance => _instance;

  factory AppCache() => _instance;

  AppCache._internal();

  final List<File> _fileCaches = [];

  Directory? _cacheDirectory;
  Directory? get cacheDirectory => _cacheDirectory;

  Directory? _appDirectory;
  Directory? get appDirectory => _appDirectory;

  initial() async {
    _appDirectory = await getApplicationDocumentsDirectory();
    printLog('create cache directory');
    Directory cacheDir = (await getTemporaryDirectory());
    if (!await cacheDir.exists()) {
      cacheDir = await cacheDir.create(recursive: true);
    }
    _cacheDirectory = cacheDir;
  }

  clean() async {
    try {
      if (_cacheDirectory != null && await _cacheDirectory!.exists()) {
        await _cacheDirectory!.delete(recursive: true);
        printLog('deleted cache dictory');
      }
      printLog('total cache files ${_fileCaches.length}');
      await _clearFileCache();
      printLog('deleted all cache files');
    } catch (error) {
      printLog(error);
    }
  }

  Future<File?> cacheImage(String imageBase64) async {
    try {
      final Uint8List imageBytes = base64.decode(imageBase64);
      final File imageFile = File('${_cacheDirectory!.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      imageFile.writeAsBytesSync(List.from(imageBytes));
      if (await imageFile.exists()) {
        return imageFile;
      }
    } catch (error) {
      printLog(error);
      return null;
    }
    return null;
  }

  void addFile(File? file) async {
    if (file != null && await file.exists()) {
      _fileCaches.add(file);
    }
  }

  void addFiles(List<File?> files) {
    for (var file in files) {
      addFile(file);
    }
  }

  _clearFileCache() async {
    try {
      for (var file in _fileCaches) {
        await file.delete();
      }
    } catch (error) {
      printLog(error);
    }
  }
}
