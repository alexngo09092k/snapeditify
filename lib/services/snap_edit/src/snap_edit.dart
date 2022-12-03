import 'package:fluttering/fluttering.dart';
import './models/config/snapedit_config.dart';
import './models/response/snapedit_response.dart';

class SnapEdit {
  SnapEditConfig _config = SnapEditConfig.defaultValue();
  SnapEditConfig get config => _config;

  SnapEdit([SnapEditConfig? config]) {
    if (config != null) _config = config;
  }

  void init(SnapEditConfig config) {
    _config = config;
  }
}

extension SnapEditResponseEx on SnapEdit {
  SnapEditResponse<T> handleResponse<T>(ClientResponse response, T Function(Map<String, dynamic>) fromData) {
    if (response.error != null || response.data == null) {
      return SnapEditResponse(error: response.error);
    }
    if (response.data['error'] != null) {
      return SnapEditResponse(
        error: response.data['error'],
        message: response.data['message'],
      );
    }
    return SnapEditResponse(data: fromData(response.data));
  }
}
