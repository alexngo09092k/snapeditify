import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/src/models/body/ai_detection_body.dart';
import 'package:snapedit/services/snap_edit/src/models/response/ai_detection_response.dart';
import 'package:snapedit/services/snap_edit/src/models/response/snapedit_response.dart';
import 'package:snapedit/services/snap_edit/src/snap_edit.dart';
import 'package:snapedit/services/snap_edit/src/models/config/snapedit_config.dart';

extension DetectedImage on SnapEdit {
  Future<SnapEditResponse<AIDetectionResponse?>> detectionImage(AIDetectionBody data) async {
    ClientResponse response = await ClientHttp.instance.post<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.ai}',
      data.toMap(),
      headers: config.headers,
    );

    return handleResponse<AIDetectionResponse>(response, (p0) => AIDetectionResponse.fromMap(p0));
  }
}
