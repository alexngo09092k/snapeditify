import 'package:snapedit/services/snap_edit/snap_edit.dart';

extension Restyle on SnapEdit {
  // Future<SnapEditResponse<RestyleResponse?>> restyle(RestyleBody data) async {
  //   ClientResponse response = await ClientHttp.instance.post<Map<String, dynamic>>(
  //     '${config.baseUrl}${config.endPoints.ai}',
  //     data.toMap(),
  //     headers: config.headers,
  //   );

  //   return handleResponse<RestyleResponse>(response, (p0) => RestyleResponse.fromMap(p0));
  // }
}
