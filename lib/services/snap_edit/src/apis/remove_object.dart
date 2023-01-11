import 'dart:io';

import 'package:fluttering/fluttering.dart';
import 'package:phosart/services/snap_edit/snap_edit.dart';
import 'package:phosart/services/snap_edit/src/utils.dart';

extension DetectedImage on SnapEdit {
  Future<SnapEditResponse<AIDetectionResponse?>> detection(AIDetectionBody body) async {
    try {
      final List<MultipartBody> files = [];
      final Map<String, dynamic> data = {};

      if (body.sessionId == null && body.originalPreviewImage == null) {
        return SnapEditResponse<AIDetectionResponse?>(data: null, error: 'Original Preview Image and Session Id, the both are null');
      }

      if (body.sessionId != null) data['session_id'] = body.sessionId;

      File? file;
      if (body.originalPreviewImage != null) {
        file = await uint8ListToFile(body.originalPreviewImage!);
        if (file == null) return SnapEditResponse<AIDetectionResponse?>(data: null, error: 'Input image is not valid.');

        files.add(MultipartBody<File>(
          key: 'original_preview_image',
          data: file,
        ));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
        '${config.baseUrl}${config.endPoints.ai}',
        data,
        files,
        headers: config.headers,
      );

      if (file != null) file.delete();

      return handleResponse<AIDetectionResponse>(response, (p0) => AIDetectionResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<AIDetectionResponse?>(error: 'Something wrongs');
    }
  }

  Future<SnapEditResponse<EraseResponse?>> erase(EraseBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      if (body.sessionId == null && body.originalPreviewImage == null) {
        return SnapEditResponse<EraseResponse?>(data: null, error: 'Original Preview Image and Session Id, the both are null.');
      }

      if (body.sessionId != null) data['session_id'] = body.sessionId;

      File? file1;
      if (body.originalPreviewImage != null) {
        file1 = await uint8ListToFile(body.originalPreviewImage!);
        if (file1 == null) return SnapEditResponse<EraseResponse?>(data: null, error: 'Original Preview Image is not valid.');
        parts.add(MultipartBody<File>(key: 'original_preview_image', data: file1));
      }

      File? file2;
      if (body.maskBrush != null) {
        file2 = await uint8ListToFile(body.maskBrush!);
        if (file2 == null) return SnapEditResponse<EraseResponse?>(data: null, error: 'Mask Brush Image is not valid.');
        parts.add(MultipartBody<File>(key: 'mask_brush', data: file2));
      }

      File? file3;
      if (body.maskBase != null) {
        file3 = await uint8ListToFile(body.maskBase!);
        if (file3 == null) return SnapEditResponse<EraseResponse?>(data: null, error: 'Mask Base Image is not valid.');
        parts.add(MultipartBody<File>(key: 'mask_base', data: file3));
      }
      if (body.maskObjects != null) data['mask_objects'] = body.maskObjects;

      ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
        '${config.baseUrl}${config.endPoints.erase}',
        data,
        parts,
        headers: config.headers,
      );

      if (file1 != null && await file1.exists()) file1.delete();
      if (file2 != null && await file2.exists()) file2.delete();
      if (file3 != null && await file3.exists()) file3.delete();

      return handleResponse<EraseResponse>(response, (p0) => EraseResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<EraseResponse?>(error: 'Something wrongs');
    }
  }
}
