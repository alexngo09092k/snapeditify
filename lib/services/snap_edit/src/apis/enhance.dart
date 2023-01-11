import 'dart:io';

import 'package:fluttering/fluttering.dart';
import 'package:phosart/services/snap_edit/src/models/body/enhance_body.dart';
import 'package:phosart/services/snap_edit/src/models/response/enhance_response.dart';
import 'package:phosart/services/snap_edit/src/models/response/snapedit_response.dart';
import 'package:phosart/services/snap_edit/src/snap_edit.dart';
import 'package:phosart/services/snap_edit/src/models/config/snapedit_config.dart';
import 'package:phosart/services/snap_edit/src/utils.dart';

extension Enhance on SnapEdit {
  Future<SnapEditResponse<EnhanceResponse?>> enhance(EnhanceBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'zoom_factor': body.zoomFactor};

      if (body.inputImage == null && body.imageId == null) {
        return SnapEditResponse<EnhanceResponse?>(data: null, error: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<EnhanceResponse?>(data: null, error: 'Input image is not valid.');
        parts.add(MultipartBody<File>(
          key: 'input_image',
          data: file,
        ));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.enhancePro}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<EnhanceResponse>(response, (p0) => EnhanceResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<EnhanceResponse?>(error: 'Something wrongs');
    }
  }
}
