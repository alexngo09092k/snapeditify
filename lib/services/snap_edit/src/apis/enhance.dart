import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/src/models/body/enhance_body.dart';
import 'package:snapedit/services/snap_edit/src/models/response/enhance_response.dart';
import 'package:snapedit/services/snap_edit/src/models/response/snapedit_response.dart';
import 'package:snapedit/services/snap_edit/src/snap_edit.dart';
import 'package:snapedit/services/snap_edit/src/models/config/snapedit_config.dart';

extension Enhance on SnapEdit {
  Future<SnapEditResponse<EnhanceResponse?>> enhance(EnhanceBody body) async {
    final List<MultipartBody> files = [];
    final Map<String, dynamic> data = {'zoom_factor': body.zoomFactor};

    if (body.inputImage == null && body.imageId == null) {
      return SnapEditResponse<EnhanceResponse?>(data: null, error: 'Input image and image id, the both are null');
    }

    if (body.inputImage != null) files.add(MultipartBody('input_image', body.inputImage!));
    if (body.imageId != null) data['image_id'] = body.imageId!;

    ClientResponse response = await ClientHttp.instance.postMultipart(
      '${config.baseUrl}${config.endPoints.enhancePro}',
      data,
      files,
      headers: config.headers,
    );

    return handleResponse<EnhanceResponse>(response, (p0) => EnhanceResponse.fromMap(p0));
  }
}
