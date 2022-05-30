Map<String, dynamic> enviroment = {
  /// enable firebase module
  /// dir: /modules/firebase/firebase_service.dart
  "firebaseConfig": {
    "enable": true,
    "enableRemoteConfigFirebase": false,
  },

  "apiConfig": {
    'url': 'https://be-prod-1.snapedit.app',
    'eraseEndPoint': '/erase/v4',
    'aiEndPoint': '/ai_detection/v4',
  },

  "appConfig": {
    "appName": "SnapEdit",
    'appLogo': 'assets/image/logo.png',
    'appVersion': '1.0',
    'appColor': '#9ab065',
    'appTheme': 'light',
  },

  "adConfig": {
    "enable": false,
    "googleTestingId": [],
    "adMobAppIdIos": "ca-app-pub-7432665165146018~2664444130",
    "adMobAppIdAndroid": "ca-app-pub-7432665165146018~2664444130",
    "ads": [
      {
        "type": "banner",
        "provider": "google",
        "iosId": "	ca-app-pub-3940256099942544/2934735716",
        "androidId": "ca-app-pub-3940256099942544/6300978111",
        "showOnScreens": [],
        "hideOnScreens": [],
        "waitingTimeToDisplay": 2,
      },
      {
        "type": "banner",
        "provider": "google",
        "iosId": "	ca-app-pub-3940256099942544/2934735716",
        "androidId": "ca-app-pub-3940256099942544/6300978111",
        "showOnScreens": [],
        "hideOnScreens": [],
      },
      {
        "type": "interstitial",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/4411468910",
        "androidId": "	ca-app-pub-3940256099942544/1033173712",
        "showOnScreens": [],
        "hideOnScreens": [],
        "waitingTimeToDisplay": 5,
      },
      {
        "type": "reward",
        "provider": "google",
        "iosId": "ca-app-pub-3940256099942544/1712485313",
        "androidId": "	ca-app-pub-3940256099942544/5224354917",
        "showOnScreens": [],
        "hideOnScreens": [],
      },
    ],
  }
};
