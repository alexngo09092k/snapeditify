import 'package:snapedit/common/configuration.dart';
import 'package:snapedit/models/ai_detection_body.dart';
import 'package:snapedit/models/ai_detection_response.dart';
import 'package:snapedit/models/erase_body.dart';
import 'package:snapedit/models/erase_response.dart';
import 'package:snapedit/utils/client_api.dart';

class AIRepository {
  final int timeoutInSeconds = 30;
  final Map<String, String> _headers = {
    'Host': 'be-prod-1.snapedit.app',
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
    'accept': '*/*',
    'content-type': 'application/json',
    'user-agent':
        'SnapEdit/1.2.3 (com.sfun.snapedit; build:37; iOS 15.1.1) Alamofire/5.5.0',
    'accept-language': 'vi-VN;q=1.0',
  };

  Future<EraseResponse?> eraseImage(EraseBody data) async {
    ClientApiResponse response = await ClientApi.postData(
      '${Cofiguration.apiConfig.url}${Cofiguration.apiConfig.eraseEndPoint}',
      data.toMap(),
      headers: _headers,
    );
    if (response.error != null) {
      return null;
    }
    return EraseResponse.fromMap(response.data);
  }

  Future<AIDetectionResponse?> detectionImage(AIDetectionBody data) async {
    ClientApiResponse response = await ClientApi.postData(
      '${Cofiguration.apiConfig.url}${Cofiguration.apiConfig.aiEndPoint}',
      data.toMap(),
      headers: _headers,
    );
    if (response.error != null) {
      return null;
    }
    return AIDetectionResponse.fromMap(response.data);
  }
}
