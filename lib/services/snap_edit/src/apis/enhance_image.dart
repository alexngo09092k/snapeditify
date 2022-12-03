import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/src/models/body/enhance_body.dart';
import 'package:snapedit/services/snap_edit/src/models/response/enhance_response.dart';
import 'package:snapedit/services/snap_edit/src/models/response/snapedit_response.dart';
import 'package:snapedit/services/snap_edit/src/snap_edit.dart';
import 'package:snapedit/services/snap_edit/src/models/config/snapedit_config.dart';

extension EnhanceImage on SnapEdit {
  Future<SnapEditResponse<EnhanceResponse?>> enhanceImage(EnhanceBody data) async {
    ClientResponse response = await ClientHttp.instance.post<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.erase}',
      data.toMap(),
      headers: config.headers,
    );

    return handleResponse<EnhanceResponse>(response, (p0) => EnhanceResponse.fromMap(p0));
  }
}
