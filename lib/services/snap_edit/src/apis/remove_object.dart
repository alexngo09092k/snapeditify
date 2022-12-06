import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';

extension DetectedImage on SnapEdit {
  Future<SnapEditResponse<AIDetectionResponse?>> detection(AIDetectionBody body) async {
    final List<MultipartBody> files = [];
    final Map<String, dynamic> data = {};

    if (body.sessionId == null && body.originalPreviewImage == null) {
      return SnapEditResponse<AIDetectionResponse?>(data: null, error: 'Original Preview Image and Session Id, the both are null');
    }

    if (body.sessionId != null) data['session_id'] = body.sessionId;
    if (body.originalPreviewImage != null) files.add(MultipartBody('original_preview_image', body.originalPreviewImage!));

    ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.ai}',
      data,
      files,
      headers: config.headers,
    );

    return handleResponse<AIDetectionResponse>(response, (p0) => AIDetectionResponse.fromMap(p0));
  }

  Future<SnapEditResponse<EraseResponse?>> erase(EraseBody body) async {
    final List<MultipartBody> files = [];
    final Map<String, dynamic> data = {};

    if (body.sessionId == null && body.originalPreviewImage == null) {
      return SnapEditResponse<EraseResponse?>(data: null, error: 'Original Preview Image and Session Id, the both are null');
    }

    if (body.sessionId != null) data['session_id'] = body.sessionId;
    if (body.originalPreviewImage != null) files.add(MultipartBody('original_preview_image', body.originalPreviewImage!));

    if (body.maskBrush != null) files.add(MultipartBody('mask_brush', body.maskBrush!));
    if (body.maskBase != null) files.add(MultipartBody('mask_base', body.maskBase!));
    if (body.maskObjects != null) data['mask_objects'] = body.maskObjects;

    ClientResponse response = await ClientHttp.instance.postMultipart<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.erase}',
      data,
      files,
      headers: config.headers,
    );

    return handleResponse<EraseResponse>(response, (p0) => EraseResponse.fromMap(p0));
  }
}
