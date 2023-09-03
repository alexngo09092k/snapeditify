import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension PassportMaker on SnapEdit {
  Future<SnapEditResponse<SkyMaskResponse?>> passportMaker(SkyMaskBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {'style_id': body.styleId};

      if (body.imageId == null && body.inputImage == null) {
        return SnapEditResponse<SkyMaskResponse?>(message: 'Input image and image id, the both are null.');
      }

      if (body.imageId != null) data['image_id'] = body.imageId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<SkyMaskResponse?>(message: 'Input image is not valid.');
        parts.add(MultipartBody<File>(key: 'input_image', data: file));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.passportMaker}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<SkyMaskResponse>(response, (p0) => SkyMaskResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<SkyMaskResponse?>(message: error.toString());
    }
  }
}
