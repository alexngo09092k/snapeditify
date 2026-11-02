import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension ChangeBackground on SnapEdit {
  Future<SnapEditResponse<BackgroundResponse?>> getBackgroundEffects([String lang = 'en']) async {
    try {
            ClientResponse<Map<String, dynamic>> response = await ClientHttp.instance.get<Map<String, dynamic>>(
        '${config.endPoints.backgroundEffects}?lang=$lang',
        headers: config.publicHeaders,
      );

      return handleResponse<BackgroundResponse>(response, (p0) => BackgroundResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<BackgroundResponse>(message: error.toString());
    }
  }

  Future<SnapEditResponse<RemoveBackgroundResponse?>> removeBackground(RemoveBackgroundBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<RemoveBackgroundResponse?>(
            message: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) {
          return SnapEditResponse<RemoveBackgroundResponse?>(message: 'Input image is not valid.');
        }
        parts.add(MultipartBody<File>(key: 'input_image', data: file));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.removeBackground}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<RemoveBackgroundResponse?>(response, (p0) {
        if (p0 is Map<String, dynamic>) {
          return RemoveBackgroundResponse.fromMap(p0);
        }
        Debug.log("ANIME IMAGE NO RESPONSE");
        return null;
      });
    } catch (error) {
      return SnapEditResponse<RemoveBackgroundResponse?>(
          message: error.toString());
    }
  }
}
