import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/models/ai_detection_body.dart';
import 'package:snapretouch/models/ai_detection_response.dart';
import 'package:snapretouch/models/erase_body.dart';
import 'package:snapretouch/models/erase_response.dart';
import 'package:snapretouch/utils/client_api.dart';

class AIRepository {
  final int timeoutInSeconds = 30;
  final Map<String, String> _iOSHeaders = {
    'Host': 'be-prod-1.snapedit.app',
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
    'accept': '*/*',
    'content-type': 'application/json',
    'user-agent':
        'SnapEdit/1.2.3 (com.sfun.snapretouch; build:37; iOS 15.1.1) Alamofire/5.5.0',
    'accept-language': 'vi-VN;q=1.0',
  };
  final Map<String, String> _androidHeaders = {
    'Host': 'be-prod-1.snapedit.app',
    'Content-Type': 'application/json; charset=UTF-8',
    'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
    'accept': '*/*',
    'content-type': 'application/json',
    'user-agent':
        'SnapEdit/1.2.3 (com.sfun.snapretouch; build:37; iOS 15.1.1) Alamofire/5.5.0',
    'accept-language': 'vi-VN;q=1.0',
  };

  _buildHeader() {
    String userAgent = '';
    return isIos ? _iOSHeaders : _androidHeaders;
  }

  Future<EraseResponse?> eraseImage(EraseBody data) async {
    ClientApiResponse response = await ClientApi.postData(
      '${Cofiguration.apiConfig.url}${Cofiguration.apiConfig.eraseEndPoint}',
      data.toMap(),
      headers: isIos ? _iOSHeaders : _androidHeaders,
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
      headers: isIos ? _iOSHeaders : _androidHeaders,
    );
    if (response.error != null) {
      return null;
    }
    return AIDetectionResponse.fromMap(response.data);
  }
}
