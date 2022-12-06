import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/snap_edit.dart';
import 'package:snapedit/services/snap_edit/src/models/response/styles_response.dart';

extension Restyle on SnapEdit {
  Future<SnapEditResponse<StylesResponse?>> getStyles([String lang = 'en']) async {
    ClientResponse<String> response = await ClientHttp.instance.get<String>(
      '${config.baseUrl}${config.endPoints.styles}?lang=$lang',
      headers: config.headers,
    );

    return handleResponse<StylesResponse>(response, (p0) => StylesResponse.fromJson(p0));
  }

  Future<SnapEditResponse<RestyleResponse?>> restyle(RestyleBody body) async {
    final List<MultipartBody> files = [];
    final Map<String, dynamic> data = {'style_id': body.styleId};

    if (body.imageId == null && body.inputImage == null) {
      return SnapEditResponse<RestyleResponse?>(data: null, error: 'Input image and image id, the both are null');
    }

    if (body.inputImage != null) files.add(MultipartBody('input_image', body.inputImage!));
    if (body.imageId != null) data['image_id'] = body.imageId!;

    ClientResponse response = await ClientHttp.instance.postMultipart(
      '${config.baseUrl}${config.endPoints.restyle}',
      data,
      files,
      headers: config.headers,
    );

    return handleResponse<RestyleResponse>(response, (p0) => RestyleResponse.fromMap(p0));
  }
}
