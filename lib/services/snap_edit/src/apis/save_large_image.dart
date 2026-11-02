import 'dart:io';
import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';
import '../utils.dart';

extension SaveLargeImage on SnapEdit {
    Future<SnapEditResponse<LargeImageResponse?>> sacelargeImage(LargeImageBody body) async {
    try {
      await ensureAuthToken();
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      if (body.inputImage == null && body.sessionId == null) {
        return SnapEditResponse<LargeImageResponse?>(message: 'Input image and image id, the both are null.');
      }

      if (body.sessionId != null) data['session_id'] = body.sessionId!;

      File? file;
      if (body.inputImage != null) {
        file = await uint8ListToFile(body.inputImage!);
        if (file == null) return SnapEditResponse<LargeImageResponse?>(message: 'Input image is not valid.');
        parts.add(MultipartBody<File>(
          key: 'input_image',
          data: file,
        ));
      }

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.saveImagelarge}',
        data,
        parts,
        headers: config.headers,
      );

      if (file != null && await file.exists()) file.delete();

      return handleResponse<LargeImageResponse>(response, (p0) => LargeImageResponse.fromMap(p0));
    } catch (error) {
      return SnapEditResponse<LargeImageResponse?>(message: error.toString());
    }
  }
}