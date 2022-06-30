import 'package:snapretouch/common/configuration.dart';
import 'package:snapretouch/common/constants.dart';
import 'package:snapretouch/models/ai_detection_body.dart';
import 'package:snapretouch/models/ai_detection_response.dart';
import 'package:snapretouch/models/erase_body.dart';
import 'package:snapretouch/models/erase_response.dart';
import 'package:snapretouch/common/app_client.dart';

class AIRepository {
  final int timeoutInSeconds = 30;

  Future<EraseResponse?> eraseImage(EraseBody data) async {
    AppClientResponse response = await AppClient.postData(
      '${Cofiguration.apiConfig.url}${Cofiguration.apiConfig.endPoints.erase}',
      data.toMap(),
      headers: isIos ? Cofiguration.apiConfig.headers.ios : Cofiguration.apiConfig.headers.android,
    );
    if (response.error != null) {
      return null;
    }
    return EraseResponse.fromMap(response.data);
  }

  Future<AIDetectionResponse?> detectionImage(AIDetectionBody data) async {
    AppClientResponse response = await AppClient.postData(
      '${Cofiguration.apiConfig.url}${Cofiguration.apiConfig.endPoints.ai}',
      data.toMap(),
      headers: isIos ? Cofiguration.apiConfig.headers.ios : Cofiguration.apiConfig.headers.android,
    );
    if (response.error != null) {
      return null;
    }
    return AIDetectionResponse.fromMap(response.data);
  }
}
