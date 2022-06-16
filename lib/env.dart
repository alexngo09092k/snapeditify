Map<String, dynamic> enviroment = {
  /// enable firebase module
  /// dir: /modules/firebase/firebase_service.dart
  "firebaseConfig": {
    "enable": true,
    "enableCrashAnalytics": false,
    "enableRemoteConfigFirebase": false,
  },

  "appConfig": {
    "name": "SnapRetouch",
    'logo': 'assets/image/logo.png',
    'version': '1.0',
    'primaryColor': '#6C76F1',
    'secondaryColor': '#72D5BB',
    'homeLogo': 'assets/images/img_logo_home_Normal@3x.png',
    'splashLogo': 'assets/images/img_splash_logo_Normal@3x.png',
    'imageProtocol': ['https://', 'http://', 'data://'],
    'homeBanner': 'assets/images/home_banner.png',
    'homeRemoveObjects': ['assets/images/home_before.jpeg', 'assets/images/home_after.jpeg'],
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

  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  "adConfig": {
    "enable": true,
    "googleTestingId": [],
    "adMobAppIdIos": "ca-app-pub-9241292359230405~3779043810",
    "adMobAppIdAndroid": "ca-app-pub-9241292359230405~3319593408",
    "ads": [
      ///GOOGLE
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
        "showOnScreens": ['home', 'edit'],
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

      ///HUAWEI
      {
        "type": "splash",
        "provider": "huawei",
        "iosId": "testq6zq98hecj",
        "androidId": "testq6zq98hecj",
      },
      {
        "type": "native",
        "provider": "huawei",
        "iosId": "testu7m3hc4gvm",
        "androidId": "testu7m3hc4gvm",
        "showOnScreens": ['home', 'edit'],
      },
      {
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "teste9ih9j0rc3",
        "androidId": "teste9ih9j0rc3",
        "showOnScreens": ['edit'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
      {
        "type": "reward",
        "provider": "huawei",
        "iosId": "testx9dtjwj8hp",
        "androidId": "testx9dtjwj8hp",
        "showOnScreens": ['edit'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
    ],
  }
};
