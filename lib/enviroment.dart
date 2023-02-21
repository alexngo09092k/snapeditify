const enviroment = {
  //! ====================================== REMOTE CONFIG ==============================================
  "remoteConfig": {
    "enable": true,
    "providers": ["huawei"],
    'fetchTimeout': 60000, // 1 minutes
    'minimumFetchInterval': 60000, // 1 minutes
  },

  //! ====================================== BUSSINESS ==============================================
  "business": {
    /// App mode
    /// production, debug, maintenance
    'appMode': 'production',

    /// Maintenance mode
    'maintenanceMode': {
      'title': "We'll be back soon",
      'message':
          "We're very sorry for the inconvenience but we're performing maintaince. Please check back soon ...",
      'link': 'https://snapeditify.netlify.app',
    },

    /// Display name is used in app
    'appName': 'SnapEditify',

    /// Version
    'version': '1.0.1',

    /// Logo is used in splash screen and app ui
    'appLogo': 'assets/images/logo.png',

    'appBio': 'Make your life beautiful',

    /// Protocols is use to check
    'protocols': ['https://', 'http://', 'data:'],

    /// Prefix stored key
    'prefix': 'app.snapeditify.studio.',

    /// Contact
    'contact': 'contact.snapeditify@gmail.com',

    /// Social Networks
    'socialNetworks': [
      {
        'brand': 'Facebook',
        'link': 'https://www.facebook.com/snapeditify/',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/600px-Facebook_Logo_%282019%29.png',
      },
      {
        'brand': 'Tiktok',
        'link': 'https://www.tiktok.com/@snapeditify',
        'image':
            'https://cdn4.iconfinder.com/data/icons/social-media-flat-7/64/Social-media_Tiktok-512.png',
      },
      {
        'brand': 'Youtube',
        'link': 'https://www.youtube.com/@snapeditify',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/YouTube_full-color_icon_%282017%29.svg/318px-YouTube_full-color_icon_%282017%29.svg.png',
      },
      {
        'brand': 'Telegram',
        'link': 'https://t.me/+GPyDosamyKA2OGVl',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/512px-Telegram_logo.svg.png?20220101141644',
      },
    ],

    /// Web links
    'webLinks': [
      {
        'title': 'Terms of service',
        'link': 'https://snapeditify.netlify.app/terms-of-service',
        'image': 'assets/images/icons/ic_term.png',
      },
      {
        'title': 'Privacy policy',
        'link': 'https://snapeditify.netlify.app/privacy-policy/',
        'image': 'assets/images/icons/ic_term.png',
      },
      {
        'title': 'FAQ',
        'link': 'https://snapeditify.netlify.app/faq',
        'image': 'assets/images/icons/ic_faq.png',
      },
    ],

    /// Share app
    'shareApp': {
      'message': 'SnapEditify AI Photo Editor Pro',
      'links': {'android': '', 'ios': '', 'huawei': ''},
    },

    'moreApps': []
  },

  //! ====================================== GALLERY ==============================================
  "gallery": {
    'countInPage': 50,
    'hasAll': true,
    'onlyAll': false,
    'minWidth': 0,
    'maxWidth': 100000,
    'minHeight': 0,
    'maxHeight': 100000,
    'ignoreSize': true,
    'minDuration': 0,
    'maxDuration': 3600000,
    'needTitle': false,
    'containsPathModified': true,
    'containsLivePhotos': false,
    'onlyLivePhotos': false,
  },

  //! ====================================== ADVERTISEMENT ==============================================
  "advertisement": {
    "enable": true,
    "adMobAppIdIos": "",
    "adMobAppIdAndroid": "",
    "providers": ["google", "huawei"],
    "ads": [
      /// HUAWEI
      {
        "type": "roll",
        "provider": "huawei",
        "iosId": "h2bea5p6f4",
        "androidId": "h2bea5p6f4",
      },
      {
        "type": "interstitial",
        "provider": "huawei",
        "iosId": "r0o9tg4ocx",
        "androidId": "r0o9tg4ocx",
      },
      {
        "type": "reward",
        "provider": "huawei",
        "iosId": "h7s9d468ol",
        "androidId": "h7s9d468ol",
      },
      {
        "type": "splash",
        "provider": "huawei",
        "iosId": "t17z7pus7m",
        "androidId": "t17z7pus7m",
      },
      {
        "type": "banner",
        "provider": "huawei",
        "iosId": "v7y4ozn8r7",
        "androidId": "v7y4ozn8r7",
      },
    ],
  },

  //! ====================================== IAP ==============================================
  "iap": {
    "enable": true,
    "providers": [],
    "products": [
      // {
      //   "type": "subscriptions",
      //   "provider": "huawei",
      //   "id": "test",
      //   "info": {
      //     "name": "",
      //     "description": "",
      //     "price": "\$1000",
      //     "rawPrice": 1000,
      //     "currency": "USD",
      //   }
      // },
      // {
      //   "type": "nonConsumables",
      //   "provider": "huawei",
      //   "id": "test2",
      //   "info": {
      //     "name": "",
      //     "description": "",
      //     "price": "\$1000",
      //     "rawPrice": 1000,
      //     "currency": "USD",
      //   }
      // }
    ],
  },

  //! ====================================== SNAPEDIT ==============================================
  "snapEdit": {
    'baseUrl': "https://be-prod-1.snapedit.app/",
    // 'apiKey': "s2svtF6qSCwBCI0Xjm4MvY0fBGVrtoUCbidhNmkvrJA=",
    'apiKey':
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ2ZXJzaW9uIjoiMy4xLjAiLCJleHAiOjE3Njk2MjI0MDEsInN1YiI6Imlnbm9yZSIsInBsYXRmb3JtIjoiYW5kcm9pZCJ9.OufJuEzKvN2RVCw-Ofy1oY6d9oRuOnM_Vxmt6aqLWAk",
    'version': "3.4.1",
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
      'animeStyles': "api/imagen/v1/styles",
      'animeStylesPro': "api/imagen/v1/styles",
      'animeImageAI': "api/imagen/v1",
      'animeImageAIPro': "api/imagen/v1",
      'animeVideoAI': "api/imagen/v1/video",
      'animeVideoAIPro': "api/imagen/v1/video",
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
};
