Map<String, dynamic> enviroment = {
  /// enable firebase module
  /// remote config
  "firebaseConfig": {
    "enableFirebase": true,
    "enableCrashAnalytics": true,
    "enableRemoteConfigFirebase": true,
    'fetchTimeout': 60,
    'minimumFetchInterval': 60,
  },

  /// Business config
  "appConfig": {
    /// App mode
    /// production, debug, maintenance
    'appMode': 'debug',

    /// Maintenance mode
    'maintenanceMode': {
      'title': "We'll be back soon",
      'message': "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      'link': 'https://t.me/+9UBuQxKY7N80YTc1',
    },

    ///Display name is used in app
    'appName': 'BlockScan',

    ///Logo is used in splash screen and app ui
    'appLogo': 'assets/images/logo.png',

    ///Protocols is use to check
    'protocols': ['https://', 'http://', 'data:'],

    ///Prefix stored key
    'sharedKeyPrefix': 'block_scan.',

    ///Contact
    'contact': 'support@bscscan.app',

    'telegram': 'https://t.me/+9UBuQxKY7N80YTc1',

    ///Share app
    'shareApp': {
      'message': 'BlockScan',
      'link': 'https://t.me/+9UBuQxKY7N80YTc1',
    },
  },

  "snapEditConfig": {
    'baseUrl': 'https://be-prod-1.snapedit.app',
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
        'user-agent': 'SnapEdit/1.2.3 (com.sfun.snapedit; build:37; iOS 15.1.1) Alamofire/5.5.0',
        'accept-language': 'vi-VN;q=1.0',
      },
      'android': {
        'Host': 'be-prod-1.snapedit.app',
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': '__cflb=02DiuFkAXusk8L9hm8nWZ2xLNeoGNMZMFM5uzAhM9PFvU',
        'accept': '*/*',
        'content-type': 'application/json',
        'user-agent': 'SnapEdit/1.2.3 (com.sfun.snapedit; build:37; iOS 15.1.1) Alamofire/5.5.0',
        'accept-language': 'vi-VN;q=1.0',
      }
    }
  },

  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  "advertisementConfig": {
    "enable": true,
    "googleTestingId": [],
    "adMobAppIdIos": "ca-app-pub-9241292359230405~3779043810",
    "adMobAppIdAndroid": "ca-app-pub-9241292359230405~3319593408",
    "ads": [
      /// GOOGLE
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

      /// HUAWEI
      {
        "type": "splash",
        "provider": "huawei",
        "iosId": "c0cs1vbgjb",
        "androidId": "c0cs1vbgjb",
      },
      {
        "type": "native",
        "provider": "huawei",
        "iosId": "q8bosp263n",
        "androidId": "q8bosp263n",
        "showOnScreens": ['home', 'edit'],
      },
      {
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "u6jhuouf85",
        "androidId": "u6jhuouf85",
        "showOnScreens": ['edit'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
    ],
  }
};
