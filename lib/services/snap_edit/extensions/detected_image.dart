import 'package:fluttering/fluttering.dart';
import 'package:snapretouch/services/services.dart';
import 'package:snapretouch/services/snap_edit/models/ai_detection_body.dart';
import 'package:snapretouch/services/snap_edit/models/ai_detection_response.dart';
import 'package:snapretouch/services/snap_edit/models/snapedit_response.dart';

extension DetectedImage on SnapEdit {
  Future<SnapEditResponse<AIDetectionResponse?>> detectionImage(AIDetectionBody data) async {
    ClientResponse response = await ClientHttp.instance.post<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.ai}',
      data.toMap(),
      headers: config.currentHeaders,
    );

    return handleResponse<AIDetectionResponse>(response, (p0) => AIDetectionResponse.fromMap(p0));
  }
}
