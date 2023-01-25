import 'dart:io';

import 'package:fluttering/fluttering.dart';
import 'package:snapeditify/services/snap_edit/snap_edit.dart';
import 'package:snapeditify/services/snap_edit/src/models/response/styles_response.dart';
import 'package:snapeditify/services/snap_edit/src/utils.dart';

extension Restyle on SnapEdit {
  Future<SnapEditResponse<StylesResponse?>> getStyles([String lang = 'en']) async {
    try {
      ClientResponse<String> response = await ClientHttp.instance.get<String>(
        '${config.baseUrl}${config.endPoints.styles}?lang=$lang',
        headers: config.headers,
      );

      return handleResponse<StylesResponse>(response, (p0) => StylesResponse.fromJson(p0));
    } catch (error) {
      return SnapEditResponse<StylesResponse>(error: error.toString());
    }
  }

  Future<SnapEditResponse<RestyleResponse?>> restyle(RestyleBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'style_id': body.styleId};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<RestyleResponse?>(data: null, error: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<RestyleResponse?>(data: null, error: 'Input image is not valid.');
        parts.add(MultipartBody<File>(key: 'input_image', data: file));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.restyle}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<RestyleResponse>(response, (p0) => RestyleResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<RestyleResponse?>(error: error.toString());
    }
  }
}
