import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension Restore on SnapEdit {
  Future<SnapEditResponse<RestorationResponse?>> restoreImage(RestoreBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'zoom_factor': body.zoomFactor};

      if (body.inputImage == null && body.imageId == null) {
        return SnapEditResponse<RestorationResponse?>(message: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<RestorationResponse?>(message: 'Input image is not valid.');
        parts.add(MultipartBody<File>(
          key: 'input_image',
          data: file,
        ));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.restoreImage}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<RestorationResponse>(response, (p0) => RestorationResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<RestorationResponse?>(message: error.toString());
    }
  }
}
