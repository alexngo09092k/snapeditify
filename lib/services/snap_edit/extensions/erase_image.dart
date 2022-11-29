import 'package:fluttering/fluttering.dart';
import 'package:snapedit/services/services.dart';
import 'package:snapedit/services/snap_edit/models/snapedit_response.dart';
import 'package:snapedit/services/snap_edit/models/erase_body.dart';
import 'package:snapedit/services/snap_edit/models/erase_response.dart';

extension EraseImage on SnapEdit {
  Future<SnapEditResponse<EraseResponse?>> eraseImage(EraseBody data) async {
    ClientResponse response = await ClientHttp.instance.post<Map<String, dynamic>>(
      '${config.baseUrl}${config.endPoints.erase}',
      data.toMap(),
      headers: config.currentHeaders,
    );

    return handleResponse<EraseResponse>(response, (p0) => EraseResponse.fromMap(p0));
  }
}
