// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart';
import 'package:snapretouch/common/logs.dart';
import 'package:flutter/foundation.dart' as foundation;
class AppClientResponse<T> {
  String? error;
  T? data;
  AppClientResponse({this.error, this.data});
}

abstract class AppClient {
  static const int timeoutInSeconds = 200;

  static Future<AppClientResponse> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      printLog('====> API Call: $uri\nHeader: $headers');
      Response response = await get(
        Uri.parse(uri),
        headers: headers,
      ).timeout(const Duration(seconds: timeoutInSeconds));
      printLog('====> API Response: $response');
      return handleResponse(response, uri);
    } catch (e) {
      printLog(e);
      return AppClientResponse(error: e.toString());
    }
  }

  static Future<AppClientResponse> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      printLog('====> API Call: $uri\nHeader: $headers');
      printLog('====> API Body: $body');
      Response response = await post(
        Uri.parse(uri),
        body: jsonEncode(body),
        headers: headers,
      ).timeout(const Duration(seconds: timeoutInSeconds));
      printLog('====> API Response: $response');
      return handleResponse(response, uri);
    } catch (e) {
      printLog(e);
      return AppClientResponse(error: e.toString());
    }
  }

  static Future<AppClientResponse> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      printLog('====> API Call: $uri\nHeader: $headers');
      printLog('====> API Body: $body');
      MultipartRequest request = MultipartRequest('POST', Uri.parse(uri));
      if (headers != null) {
        request.headers.addAll(headers);
      }
      for (MultipartBody multipart in multipartBody) {
        if (foundation.kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          MultipartFile part = MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            list.length,
            filename: basename(multipart.file.path),
            contentType: MediaType('image', 'jpg'),
          );
          request.files.add(part);
        } else {
          File file = File(multipart.file.path);
          request.files.add(MultipartFile(
            multipart.key,
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      Response response = await Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      printLog(e);
      return AppClientResponse(error: e.toString());
    }
  }

  static Future<AppClientResponse> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      printLog('====> API Call: $uri\nHeader: $headers');
      printLog('====> API Body: $body');
      Response response = await put(
        Uri.parse(uri),
        body: jsonEncode(body),
        headers: headers,
      ).timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      printLog(e);
      return AppClientResponse(error: e.toString());
    }
  }

  static Future<AppClientResponse> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      printLog('====> API Call: $uri\nHeader: $headers');
      Response response = await delete(
        Uri.parse(uri),
        headers: headers ?? headers,
      ).timeout(const Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      printLog(e);
      return AppClientResponse(error: e.toString());
    }
  }

  static AppClientResponse handleResponse(Response response, String uri) {
    try {
      printLog('======> status code ${response.statusCode}');
      final data = jsonDecode(response.body);
      printLog('======> After json decoded $data');
      if (data['error'] != null) {
        throw data['error'];
      }
      return AppClientResponse(error: null, data: data);
    } catch (e) {
      return AppClientResponse(error: e.toString());
    }
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
