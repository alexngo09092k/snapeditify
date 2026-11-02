import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension MakePassportID on SnapEdit {
   Future<SnapEditResponse<MakePassportIDResponse?>> makePassportID(MakePassportIDBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<MakePassportIDResponse?>(
            message: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) {
          return SnapEditResponse<MakePassportIDResponse?>(message: 'Input image is not valid.');
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

      return handleResponse<MakePassportIDResponse?>(response, (p0) {
        if (p0 is Map<String, dynamic>) {
          return MakePassportIDResponse.fromMap(p0);
        }
        Debug.log("ANIME IMAGE NO RESPONSE");
        return null;
      });
    } catch (error) {
      return SnapEditResponse<MakePassportIDResponse?>(
          message: error.toString());
    }
  }
}
