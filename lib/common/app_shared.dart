import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapedit/common/logs.dart';

abstract class AppShared {
  static SharedPreferences? sharedPreferences;

  static Future<SharedPreferences?> init() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } catch (error) {
      printLog(error);
    }
    return null;
  }
}
