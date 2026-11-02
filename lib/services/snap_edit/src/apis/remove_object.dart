import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension DetectedImage on SnapEdit {
  Future<SnapEditResponse<ScanObjectResponse?>> scanObject(ScanObjectBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> files = [];
      final Map<String, dynamic> data = {};

      if (body.sessionId == null && body.originalPreviewImage == null) {
        return SnapEditResponse<ScanObjectResponse>(message: 'Original Preview Image and Session Id, the both are null');
      }

      if (body.sessionId != null) data['session_id'] = body.sessionId;

      File? file;
      if (body.originalPreviewImage != null) {
        file = await uint8ListToFile(body.originalPreviewImage!);
        if (file == null) {
          return SnapEditResponse<ScanObjectResponse?>(message: 'Input image is not valid.');
        }
        files.add(MultipartBody<File>(
          key: 'original_preview_image',
          data: file,
        ));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
        '${config.baseUrl}${config.endPoints.scanObject}',
        data,
        files,
        headers: config.headers,
      );

      if (file != null) file.delete();

      return handleResponse<ScanObjectResponse>(response, (p0) => ScanObjectResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<ScanObjectResponse?>(message: error.toString());
    }
  }

  Future<SnapEditResponse<OneTouchSuggestionResponse?>> removeOneTouch(OneTouchSuggestionBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      if (body.sessionId == null && body.originalPreviewImage == null) {
        return SnapEditResponse<OneTouchSuggestionResponse?>(message: 'Original Preview Image and Session Id, the both are null.');
      }

      if (body.sessionId != null) data['session_id'] = body.sessionId;

      File? file1;
      if (body.originalPreviewImage != null) {
        file1 = await uint8ListToFile(body.originalPreviewImage!);
        if (file1 == null) {
          return SnapEditResponse<OneTouchSuggestionResponse?>(message: 'Original Preview Image is not valid.');
        }
        parts.add(MultipartBody<File>(key: 'original_preview_image', data: file1));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
        '${config.baseUrl}${config.endPoints.removeOneTouch}',
        data,
        parts,
        headers: config.headers,
      );

      if (file1 != null && await file1.exists()) file1.delete();

      return handleResponse<OneTouchSuggestionResponse>(response, (p0) => OneTouchSuggestionResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<OneTouchSuggestionResponse?>(message: error.toString());
    }
  }

  Future<SnapEditResponse<RemoveObjectResponse?>> removeObject(RemoveObjectBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      if (body.sessionId == null && body.originalPreviewImage == null) {
        return SnapEditResponse<RemoveObjectResponse?>(message: 'Original Preview Image and Session Id, the both are null.');
      }

      if (body.sessionId != null) data['session_id'] = body.sessionId;

      File? file1;
      if (body.originalPreviewImage != null) {
        file1 = await uint8ListToFile(body.originalPreviewImage!);
        if (file1 == null) {
          return SnapEditResponse<RemoveObjectResponse?>(message: 'Original Preview Image is not valid.');
        }
        parts.add(MultipartBody<File>(key: 'original_preview_image', data: file1));
      }

      File? file2;
      if (body.maskBrush != null) {
        file2 = await uint8ListToFile(body.maskBrush!);
        if (file2 == null) {
          return SnapEditResponse<RemoveObjectResponse?>(message: 'Mask Brush Image is not valid.');
        }
        parts.add(MultipartBody<File>(key: 'mask_brush', data: file2));
      }

      File? file3;
      if (body.maskBase != null) {
        file3 = await uint8ListToFile(body.maskBase!);
        if (file3 == null) {
          return SnapEditResponse<RemoveObjectResponse?>(message: 'Mask Base Image is not valid.');
        }
        parts.add(MultipartBody<File>(key: 'mask_base', data: file3));
      }
      if (body.maskObjects != null) data['mask_objects'] = body.maskObjects;

      ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
        '${config.baseUrl}${config.endPoints.removeObject}',
        data,
        parts,
        headers: config.headers,
      );

      if (file1 != null && await file1.exists()) file1.delete();
      if (file2 != null && await file2.exists()) file2.delete();
      if (file3 != null && await file3.exists()) file3.delete();

      return handleResponse<RemoveObjectResponse>(response, (p0) => RemoveObjectResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<RemoveObjectResponse?>(message: error.toString());
    }
  }
}
