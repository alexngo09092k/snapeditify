import 'package:fluttering/fluttering.dart';
import '../models/models.dart';
import '../snap_edit.dart';

extension GenerateVideo on SnapEdit {
  Future<SnapEditResponse<GenerateVideoResponse?>>generateVideo(GenerateVideoBody body) async {
    try {
      final List<MultipartBody> parts = [];
      final Map<String, dynamic> data = {};

      data['image_id'] = body.imageId;
      data['output_image_id'] = body.outputImageId;

      ClientResponse response = await ClientHttp.instance.postMultipart(
        '${config.baseUrl}${config.endPoints.generateVideo}',
        data,
        parts,
        headers: config.headers,
      );

      return handleResponse<GenerateVideoResponse?>(response, (p0) {
        if (p0 is Map<String, dynamic>) return GenerateVideoResponse.fromMap(p0);
        Debug.log("RESTORE VIDEO NO RESPONSE");
        return null;
      });
    } catch (error) {
      return SnapEditResponse<GenerateVideoResponse?>(message: error.toString());
    }
  }
}
