import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/snap_edit/src/models/body/erase_body.dart';
import 'package:snapedit/services/snap_edit/src/models/response/erase_response.dart';
import 'package:snapedit/services/snap_edit/src/models/response/snapedit_response.dart';
import 'package:snapedit/services/snap_edit/src/snap_edit.dart';
import 'package:snapedit/services/snap_edit/src/models/config/snapedit_config.dart';

extension EraseImage on SnapEdit {
  Future<SnapEditResponse<EraseResponse?>> eraseImage(EraseBody data) async {
    ClientResponse response = await ClientHttp.instance.post<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.erase}',
      data.toMap(),
      headers: config.headers,
    );

    return handleResponse<EraseResponse>(response, (p0) => EraseResponse.fromMap(p0));
  }
}
