import 'package:fluttering/fluttering.dart';
import './models/config/snapedit_config.dart';
import './models/response/snapedit_response.dart';

class SnapEdit {
  SnapEditConfig _config = SnapEditConfig.defaultValue();
  SnapEditConfig get config => _config;

  SnapEdit([SnapEditConfig? config]) {
    if (config != null) _config = config;
  }

  void initital(SnapEditConfig config) {
    _config = config;
  }
}

extension SnapEditResponseEx on SnapEdit {
  SnapEditResponse<T> handleResponse<T>(ClientResponse response, T Function(dynamic) fromData) {
    Debug.log("======= HANDLE RESPONSE DATA ${response.data} =======");
    if (response.error != null || response.data == null) {
      Debug.log("======= HANDLE RESPONSE ERROR ${response.error} =======");
      return SnapEditResponse(message: response.error.toString());
    }

    if (response.data is Map) {
      /// {"msg":"Bad Authorization header. Expected 'Authorization: Bearer <JWT>'"}
      if (response.data['msg'] != null) {
        Debug.log("======= HANDLE RESPONSE ERROR ${response.data['msg']} =======");
        return SnapEditResponse(message: response.data['msg'].toString());
      }

      /// {"error":"Exception: Image shape (1520, 720, 3) too large for free users"}
      if (response.data['error'] != null) {
        Debug.log("======= HANDLE RESPONSE ERROR ${response.data['error']} =======");
        return SnapEditResponse(message: response.data['error'].toString());
      }
    }

    return SnapEditResponse<T>(status: true, data: fromData(response.data));
  }
}
