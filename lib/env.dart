Map<String, dynamic> enviroment = {
  /// enable firebase module
  /// dir: /modules/firebase/firebase_service.dart
  "firebaseConfig": {
    "enable": true,
    "enableRemoteConfigFirebase": false,
  },
  "apiConfig": {
    'url': 'https://be-prod-1.snapedit.app',
    'endPoints': {
      'erase': '/erase/v4',
      'ai': '/ai_detection/v4',
    },
    'headers': {
      'ios': {
        'Host': 'be-prod-1.snapedit.app',
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
        'accept': '*/*',
        'content-type': 'application/json',
        'user-agent': 'SnapEdit/1.2.3 (com.sfun.snapretouch; build:37; iOS 15.1.1) Alamofire/5.5.0',
        'accept-language': 'vi-VN;q=1.0',
      },
      'android': {
        'Host': 'be-prod-1.snapedit.app',
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
        'accept': '*/*',
        'content-type': 'application/json',
        'user-agent': 'SnapEdit/1.2.3 (com.sfun.snapretouch; build:37; iOS 15.1.1) Alamofire/5.5.0',
        'accept-language': 'vi-VN;q=1.0',
      }
    }
  },

  "appConfig": {
    "appName": "SnapRetouch",
    'appLogo': 'assets/image/logo.png',
    'appVersion': '1.0',
    'appColor': '#6C76F1',
    'appTheme': 'light',
  },
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  "adConfig": {
    "enable": true,
    "googleTestingId": [],
    "adMobAppIdIos": "ca-app-pub-9241292359230405~3779043810",
    "adMobAppIdAndroid": "ca-app-pub-9241292359230405~3319593408",
    "ads": [
      {
        "type": "openApp",
        "provider": "google",
        "iosId": "ca-app-pub-9241292359230405/6760430376",
        "androidId": "ca-app-pub-9241292359230405/8949811147",
      },
      {
        "type": "banner",
        "provider": "google",
        "iosId": "ca-app-pub-9241292359230405/6213635465",
        "androidId": "ca-app-pub-9241292359230405/5562613364",
        "showOnScreens": ['home'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
      {
        "type": "interstitial",
        "provider": "google",
        "iosId": "ca-app-pub-9241292359230405/8456655423",
        "androidId": "ca-app-pub-9241292359230405/8735571613",
        "showOnScreens": ['edit'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
      {
        "type": "reward",
        "provider": "google",
        "iosId": "ca-app-pub-9241292359230405/8265083730",
        "androidId": "ca-app-pub-9241292359230405/9473938213",
        "showOnScreens": ['edit'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
    ],
  }
};
