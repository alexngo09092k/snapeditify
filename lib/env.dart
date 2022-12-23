//! NOTE: UNIT TIME: SECONDS
Map<String, dynamic> enviroment = {
  /// FIREBASE
  "firebaseConfig": {
    "enableFirebase": true,
    "enableCrashAnalytics": true,
    "enableRemoteConfigFirebase": true,
    'fetchTimeout': 60,
    'minimumFetchInterval': 60,
  },

  /// APP
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
    'appName': 'SnapEdit',

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

  /// SNAPEDIT
  'snapEditConfig': {
    'baseUrl': "https://be-prod-1.snapedit.app/",
    'apiKey': "s2svtF6qSCwBCI0Xjm4MvY0fBGVrtoUCbidhNmkvrJA=",
    'version': "v6",
    'endPoints': {
      'erase': 'api/v6/erase',
      'erasePro': 'api/v6/erase',
      'ai': 'api/v6/ai_detection',
      'aiPro': 'api/v6/ai_detection',
      'enhance': 'api/v2/enhance',
      'enhancePro': 'api/v2/pro/enhance',
      'restyle': 'api/v1/restyle',
      'restylePro': 'api/v1/restyle',
      'styles': 'api/v1/restyle/styles',
      'stylesPro': 'api/v1/restyle/styles',
    },
    'enhance': {
      'suportedImageSize': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
      'uploadImageSize': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
      'upscaleMaxImageSize': 1000,
    },
    'restyle': {
      'dimension': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
    },
    'removeObject': {
      'dimension': {
        'high': 1920,
        'standard': 1920,
        'pro': 3000,
      },
      'strokeWidth': {
        'min': 1,
        'max': 100,
        'init': 30,
        'color': [255, 255, 255, 0.5],
      }
    },
    'waterMark': false,
    'maxFreeDownloadCount': 100,
  },

  // ADVERTISEMENT
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  "advertisementConfig": {
    "enable": true,
    "googleTestingId": [],
    "adMobAppIdIos": "",
    "adMobAppIdAndroid": "",
    "ads": [
      /// GOOGLE
      {
        "type": "openApp",
        "provider": "google",
        "iosId": "",
        "androidId": "",
      },

      /// HUAWEI
      {
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "",
        "androidId": "",
        "showOnScreens": ['edit'],
        "hideOnScreens": ['edit'],
        "waitingTimeToDisplay": 5,
      },
    ],
  },
  //IN APP PURCHASE
  "iapConfig": {
    "products": [
      {
        "type": "",
        "provider": "google",
        "id": "123456789",
        "info": {
          "name": "",
          "description": "",
          "price": "\$1000",
          "rawPrice": 1000,
          "currency": "USD",
        }
      }
    ],
    "provider": "google",
    "enable": true,
  }
};
