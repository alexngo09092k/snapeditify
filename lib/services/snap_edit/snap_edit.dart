import 'package:fluttering/fluttering.dart';
import 'package:snapretouch/services/snap_edit/models/snapedit_api_config.dart';
import 'package:snapretouch/services/snap_edit/models/snapedit_response.dart';

export './extensions/detected_image.dart';
export './extensions/erase_image.dart';

class SnapEdit {
  SnapEditConfig _config = SnapEditConfig();
  SnapEditConfig get config => _config;

  SnapEdit([SnapEditConfig? config]) {
    if (config != null) _config = config;
  }

  void init(SnapEditConfig config) {
    _config = config;
  }

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
